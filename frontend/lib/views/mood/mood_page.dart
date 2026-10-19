import 'package:flutter/material.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  String selectedMood = '';

  final moods = [
    ['😊', 'Happy'],
    ['🙂', 'Okay'],
    ['😔', 'Sad'],
    ['😰', 'Anxious'],
    ['😡', 'Angry'],
    ['😴', 'Tired'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Mood')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How are you feeling today?', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                itemCount: moods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  final selected = selectedMood == mood[1];

                  return GestureDetector(
                    onTap: () {
                      setState(() { selectedMood = mood[1]; });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFFE2DCF8) : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected ? const Color(0xFF6C63A8) : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(mood[0], style: const TextStyle(fontSize: 45)),
                          const SizedBox(height: 10),
                          Text(mood[1], style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedMood.isNotEmpty)
              Center(
                child: Text(
                  'Today I feel $selectedMood 💜',
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}