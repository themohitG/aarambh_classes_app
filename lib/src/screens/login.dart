import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onStudent;
  final VoidCallback onTeacher;
  final VoidCallback onAdmin;
  const LoginScreen({super.key, required this.onStudent, required this.onTeacher, required this.onAdmin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String role = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: "Student", label: Text("Student")),
                ButtonSegment(value: "Teacher", label: Text("Teacher")),
                ButtonSegment(value: "Admin", label: Text("Admin")),
              ],
              selected: {role},
              onSelectionChanged: (s) => setState(() => role = s.first),
            ),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "Email or Phone")),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                switch (role) {
                  case "Student": widget.onStudent(); break;
                  case "Teacher": widget.onTeacher(); break;
                  case "Admin": widget.onAdmin(); break;
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: const Text("Forgot password?")),
          ],
        ),
      ),
    );
  }
}
