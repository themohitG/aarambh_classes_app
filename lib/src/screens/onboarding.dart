import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback onDone;
  const OnboardingScreen({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Center(child: Icon(Icons.menu_book, size: 120, color: Colors.black87))),
            const Text("Learn Smarter with Aarambh", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Classes 6–12 • Mathematics UG/PG • Physics • Chemistry • Biology • Business Studies • Economics"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onDone, child: const Text("Get Started")),
          ],
        ),
      ),
    );
  }
}
