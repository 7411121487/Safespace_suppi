import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  // Store answers (0 to 3 scale)
  final Map<int, int> _answers = {};
  bool _submitted = false;
  int _totalScore = 0;

  final List<String> questions = [
    "Over the last 2 weeks, how often have you felt nervous or on edge?",
    "How often have you felt unable to control your worrying?",
    "How often have you felt down, depressed, or hopeless?"
  ];

  final List<String> options = [
    "Not at all (0)",
    "Several days (1)",
    "More than half the days (2)",
    "Nearly every day (3)"
  ];

  void _submitExam() {
    if (_answers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions.')),
      );
      return;
    }

    int score = 0;
    _answers.forEach((key, value) {
      score += value;
    });

    setState(() {
      _totalScore = score;
      _submitted = true;
    });

    // Here you would make an HTTP POST request to your FastAPI backend:
    // /api/assessment/submit passing the _totalScore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Assessment'),
        backgroundColor: Colors.transparent,
      ),
      body: _submitted ? _buildResults() : _buildQuiz(),
    );
  }

  Widget _buildQuiz() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: questions.length + 1,
      itemBuilder: (context, index) {
        if (index == questions.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6C63A8),
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: _submitExam,
              child: const Text("Submit Assessment", style: TextStyle(fontSize: 18)),
            ),
          );
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Q${index + 1}: ${questions[index]}",
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...List.generate(options.length, (optionIndex) {
                  return RadioListTile<int>(
                    title: Text(options[optionIndex]),
                    value: optionIndex,
                    groupValue: _answers[index],
                    activeColor: const Color(0xFF6C63A8),
                    onChanged: (int? value) {
                      setState(() {
                        _answers[index] = value!;
                      });
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResults() {
    String message = "You're managing well. Keep it up!";
    if (_totalScore >= 7) {
      message = "You are carrying a lot right now. Please reach out to someone you trust.";
    } else if (_totalScore >= 4) {
      message = "You have moderate stress. Let's try some breathing exercises.";
    }

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_rounded, size: 80, color: Color(0xFFD96C91)),
          const SizedBox(height: 20),
          Text(
            "Assessment Complete",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF403A68)),
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.black54),
          ),
          const SizedBox(height: 40),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF6C63A8)),
            onPressed: () => Navigator.pop(context),
            child: const Text("Return to SafeSpace"),
          )
        ],
      ),
    );
  }
}