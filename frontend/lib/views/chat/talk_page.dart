import 'package:flutter/material.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  final controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    messages.add({
      'sender': 'SafeSpace',
      'text':
          'Hi 💜 I am here to listen. You do not need to explain everything perfectly. Tell me what you are feeling.',
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  bool containsAny(String text, List<String> words) {
    return words.any((word) => text.contains(word));
  }

  String getResponse(String input) {
    final text = input.toLowerCase().trim();

    if (containsAny(text, [
      'suicide', 'suicidal', 'kill myself', 'end my life', 'want to die',
      'wanna die', 'die today', 'hurt myself', 'harm myself', 'self harm', 'self-harm',
    ])) {
      return '''
I'm really glad you told me. 💜

If you feel like you might hurt yourself or you are in immediate danger, please don't stay alone with this feeling.

For the next few minutes:
* Move away from anything you could use to hurt yourself.
* Go somewhere where another person is present.
* Tell someone you trust exactly what is happening.
* You can also call Tele-MANAS at 14416 for mental-health support in India.

You don't have to solve your whole life right now. Let's focus only on getting you through this moment safely.

Would you like to try a slow breathing exercise with me? 🌱
''';
    }

    return '''
Thank you for telling me. 💜

I'm listening. You don't have to find the perfect words or explain everything at once.

What would feel most helpful right now?
''';
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'sender': 'You', 'text': text});
      controller.clear();
      messages.add({'sender': 'SafeSpace', 'text': getResponse(text)});
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Talk to SafeSpace')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'You';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 650),
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFFD9DDF5) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['sender']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF403A68),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message['text']!,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'How are you feeling?',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: const Color(0xFF6C63A8),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}