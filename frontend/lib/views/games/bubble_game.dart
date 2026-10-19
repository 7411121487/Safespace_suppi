import 'dart:math';
import 'package:flutter/material.dart';

class BubbleGame extends StatefulWidget {
  const BubbleGame({super.key});

  @override
  State<BubbleGame> createState() => _BubbleGameState();
}

class _BubbleGameState extends State<BubbleGame> {
  int score = 0;
  final random = Random();
  double left = 100;
  double top = 200;

  void popBubble() {
    setState(() {
      score++;
      left = 30 + random.nextDouble() * 280;
      top = 100 + random.nextDouble() * 450;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bubble Pop')),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Bubbles popped: $score',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: left,
            top: top,
            child: GestureDetector(
              onTap: popBubble,
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.withValues(alpha: .25),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: const Center(child: Text('🫧', style: TextStyle(fontSize: 35))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}