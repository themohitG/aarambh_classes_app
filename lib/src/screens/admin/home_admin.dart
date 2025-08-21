import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AARAMBH – Admin")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AdminCard(title: "Manage Users", icon: Icons.group_outlined, onTap: () {}),
          _AdminCard(title: "Courses / Classes", icon: Icons.library_books_outlined, onTap: () {}),
          _AdminCard(title: "Announcements", icon: Icons.campaign_outlined, onTap: () {}),
          _AdminCard(title: "Reports", icon: Icons.insights_outlined, onTap: () {}),
          const SizedBox(height: 12),
          const Text("Note: This is a minimal scaffold. Connect to Firebase Auth and Firestore to make these functional."),
        ],
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final String title; final IconData icon; final VoidCallback onTap;
  const _AdminCard({required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: onTap));
  }
}
