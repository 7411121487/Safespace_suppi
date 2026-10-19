import 'package:flutter/material.dart';
import 'bubble_game.dart';
import 'memory_game.dart';
import '../breathing/breathing_page.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stress Relief Games')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Choose a little distraction 💜',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _gameCard(context, 'Bubble Pop', 'Pop colourful bubbles and slow down your thoughts.', '🫧', const BubbleGame()),
          _gameCard(context, 'Memory Match', 'A simple memory game to focus your attention.', '🧠', const MemoryGame()),
          _gameCard(context, 'Breathing Circle', 'Follow the circle and match your breathing.', '🌬️', const BreathingPage()),
        ],
      ),
    );
  }

  Widget _gameCard(BuildContext context, String title, String subtitle, String emoji, Widget page) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: Text(emoji, style: const TextStyle(fontSize: 38)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.play_arrow_rounded),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}