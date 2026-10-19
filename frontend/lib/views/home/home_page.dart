import 'package:flutter/material.dart';
import '../chat/talk_page.dart';
import '../breathing/breathing_page.dart';
import '../games/games_page.dart';
import '../mood/mood_page.dart';
import '../journal/journal_page.dart';
import '../help/help_page.dart';

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeSpace',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        children: [
          Text(
            'Hi, $name 🌱',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF403A68),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'How would you like to take care of yourself today?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 25),
          _homeCard(
            context,
            icon: Icons.chat_bubble_outline_rounded,
            color: const Color(0xFF6C63A8),
            title: 'Talk to SafeSpace',
            subtitle: 'Tell me what is on your mind.',
            page: const TalkPage(),
          ),
          _homeCard(
            context,
            icon: Icons.spa_rounded,
            color: const Color(0xFF65A77B),
            title: 'Relax & Breathe',
            subtitle: 'Slow down and calm your body.',
            page: const BreathingPage(),
          ),
          _homeCard(
            context,
            icon: Icons.videogame_asset_outlined,
            color: const Color(0xFFE28B6F),
            title: 'Stress Relief Games',
            subtitle: 'Play calming mini-games.',
            page: const GamesPage(),
          ),
          _homeCard(
            context,
            icon: Icons.favorite_outline_rounded,
            color: const Color(0xFFD96C91),
            title: 'My Mood',
            subtitle: 'Check in with yourself.',
            page: const MoodPage(),
          ),
          _homeCard(
            context,
            icon: Icons.edit_note_rounded,
            color: const Color(0xFF5C8DB8),
            title: 'Write Your Thoughts',
            subtitle: 'Let your thoughts out privately.',
            page: const JournalPage(),
          ),
          _homeCard(
            context,
            icon: Icons.shield_outlined,
            color: const Color(0xFFC76B6B),
            title: 'Get Help',
            subtitle: 'Find immediate support options.',
            page: const HelpPage(),
          ),
        ],
      ),
    );
  }

  Widget _homeCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}