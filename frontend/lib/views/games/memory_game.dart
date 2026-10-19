import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final List<String> symbols = ['🌱', '🌱', '🌸', '🌸', '🌈', '🌈', '⭐', '⭐'];
  List<bool> revealed = List.filled(8, false);
  int? firstIndex;
  bool locked = false;
  int matches = 0;

  @override
  void initState() {
    super.initState();
    symbols.shuffle();
  }

  void tapCard(int index) async {
    if (locked || revealed[index]) return;

    setState(() { revealed[index] = true; });

    if (firstIndex == null) {
      firstIndex = index;
      return;
    }

    locked = true;

    if (symbols[firstIndex!] == symbols[index]) {
      matches++;
      setState(() {
        firstIndex = null;
        locked = false;
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 700));
      setState(() {
        revealed[firstIndex!] = false;
        revealed[index] = false;
        firstIndex = null;
        locked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Match')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Match the peaceful pairs 🌱', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Pairs found: $matches / 4'),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => tapCard(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: revealed[index] ? Colors.white : const Color(0xFF6C63A8),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          revealed[index] ? symbols[index] : '?',
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}