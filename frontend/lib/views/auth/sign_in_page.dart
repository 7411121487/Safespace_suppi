import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'welcome_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isButtonEnabled = false;

  final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]{2,30}$');
  final RegExp _emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    final isNameValid = _nameRegExp.hasMatch(name);
    final isEmailValid = _emailRegExp.hasMatch(email);

    setState(() {
      isButtonEnabled = isNameValid && isEmailValid;
    });
  }

  void enterSafeSpace() {
    if (_formKey.currentState!.validate() && isButtonEnabled) {
      final name = nameController.text.trim();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WelcomePage(name: name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF1ECFF),
              Color(0xFFE7F4F0),
              Color(0xFFFFF7F0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 30,
                          color: Colors.black.withValues(alpha: .08),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.spa_rounded,
                      size: 65,
                      color: Color(0xFF6C63A8),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'SafeSpace',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF403A68),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A gentle place to pause,\nbreathe and feel heard.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .9),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          const Text(
                            'Create your safe space',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: nameController,
                            onChanged: (_) => _validateInputs(),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              if (val.trim().length < 2) {
                                return 'Name must be at least 2 characters long';
                              }
                              if (!_nameRegExp.hasMatch(val.trim())) {
                                return 'Only letters and spaces allowed';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Your name',
                              prefixIcon: const Icon(Icons.person_outline),
                              filled: true,
                              fillColor: const Color(0xFFF7F5FC),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) => _validateInputs(),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!_emailRegExp.hasMatch(val.trim())) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: const Color(0xFFF7F5FC),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: FilledButton(
                              onPressed:
                                  isButtonEnabled ? enterSafeSpace : null,
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF6C63A8),
                                disabledBackgroundColor: const Color(0xFF6C63A8)
                                    .withValues(alpha: .4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'Enter SafeSpace',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'You deserve a space where you can be yourself.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}