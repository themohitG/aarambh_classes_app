import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onNext;
  const SplashScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    // Corrected: Wrap onNext in an anonymous function to ensure it's called.
    Future.delayed(const Duration(milliseconds: 1200), () {
      onNext();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 90, width: 90, decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Colors.black12),
              child: const Icon(Icons.school, size: 56)),
            const SizedBox(height: 16),
            const Text("AARAMBH CLASSES", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text("THE BEGINNING", style: TextStyle(letterSpacing: 2, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
