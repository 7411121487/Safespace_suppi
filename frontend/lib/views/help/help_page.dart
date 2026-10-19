import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<void> callTeleManas() async {
    final uri = Uri.parse('tel:14416');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Help')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.favorite, color: Color(0xFFC76B6B), size: 38),
                SizedBox(height: 15),
                Text(
                  "You don't have to face everything alone.",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'If you feel unsafe or think you may hurt yourself, '
                  'please reach out to another person and get immediate support.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tele-MANAS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Government of India mental-health support.', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFF6C63A8)),
                      SizedBox(width: 10),
                      Text('14416', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: callTeleManas,
                      icon: const Icon(Icons.call),
                      label: const Text('Call 14416'),
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