
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PeZetUuuApp());
}

class PeZetUuuApp extends StatelessWidget {
  const PeZetUuuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeZetUuu',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
