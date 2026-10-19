import 'package:flutter/material.dart';
import 'views/auth/sign_in_page.dart';

void main() {
  runApp(const SafeSpaceApp());
}

class SafeSpaceApp extends StatelessWidget {
  const SafeSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeSpace',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F5FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63A8),
          brightness: Brightness.light,
        ),
        fontFamily: 'Arial',
      ),
      home: const SignInPage(),
    );
  }
}