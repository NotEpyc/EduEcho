import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const EduEchoApp());
}

class EduEchoApp extends StatelessWidget {
  const EduEchoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduEcho',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
    );
  }
}
