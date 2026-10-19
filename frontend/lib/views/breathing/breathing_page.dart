import 'package:flutter/material.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool breathing = false;
  String phase = 'Ready';
  int water = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> startBreathing() async {
    if (breathing) return;
    setState(() { breathing = true; });

    for (int i = 0; i < 4; i++) {
      setState(() { phase = 'Breathe in...'; });
      await controller.forward();

      setState(() { phase = 'Hold...'; });
      await Future.delayed(const Duration(seconds: 2));

      setState(() { phase = 'Breathe out...'; });
      await controller.reverse();

      setState(() { water++; });
      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() {
      phase = 'Well done 🌱';
      breathing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final plantSize = 70.0 + water * 15;

    return Scaffold(
      appBar: AppBar(title: const Text('Relax & Breathe')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Grow your little plant 🌱',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Every completed breath gives your plant a little water.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 35),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: plantSize,
                height: plantSize,
                child: const FittedBox(child: Text('🌱')),
              ),
              const SizedBox(height: 25),
              Text(
                phase,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF65A77B),
                ),
              ),
              const SizedBox(height: 30),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  final scale = 0.8 + controller.value * .35;
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFBEE6D0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF65A77B).withValues(alpha: .2),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          breathing ? 'Breathe' : 'Begin',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: breathing ? null : startBreathing,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF65A77B),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                ),
                child: Text(breathing ? 'Breathing...' : 'Start breathing'),
              ),
              const SizedBox(height: 20),
              Text('Water drops: $water 💧', style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}