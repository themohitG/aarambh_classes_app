import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int index = 0; // 0 Dashboard, 1 Resources, 2 Tests, 3 Doubts, 4 Progress

  @override
  Widget build(BuildContext context) {
    final tabs = ["Home", "Resources", "Tests", "Doubts", "Progress"];
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text("AARAMBH – Student")),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(icon: Icon(Icons.folder_open), label: "Resources"),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), label: "Tests"),
          NavigationDestination(icon: Icon(Icons.help_outline), label: "Doubts"),
          NavigationDestination(icon: Icon(Icons.show_chart), label: "Progress"),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: [
          _HomeTab(),
          _ResourcesTab(items: state.resources),
          _TestsTab(items: state.tests),
          _DoubtsTab(),
          _ProgressTab(points: state.scores),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _QuickCard(title: "My Classes", icon: Icons.school, color: Colors.black87, onTap: () {}),
        Row(children: [
          Expanded(child: _QuickCard(title: "Resources", icon: Icons.folder_open, color: Colors.redAccent, onTap: () {})),
          const SizedBox(width: 12),
          Expanded(child: _QuickCard(title: "Tests", icon: Icons.assignment_outlined, color: Colors.orangeAccent, onTap: () {})),
        ]),
        Row(children: [
          Expanded(child: _QuickCard(title: "Doubt Box", icon: Icons.help_outline, color: Colors.blueGrey, onTap: () {})),
          const SizedBox(width: 12),
          Expanded(child: _QuickCard(title: "Progress", icon: Icons.show_chart, color: Colors.green, onTap: () {})),
        ]),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String title; final IconData icon; final Color color; final VoidCallback onTap;
  const _QuickCard({required this.title, required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(children: [
          Container(height: 40, width: 40, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color)),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
      ),
    ));
  }
}

class _ResourcesTab extends StatelessWidget {
  final List<ResourceItem> items;
  const _ResourcesTab({required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Resources", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        for (final r in items)
          Card(child: ListTile(
            title: Text(r.title),
            subtitle: Text("${r.subject} • ${r.grade} • ${r.type}"),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => launchUrl(Uri.parse(r.url), mode: LaunchMode.externalApplication),
          )),
        const SizedBox(height: 24),
        const Text("Tip: Replace links with your Google Drive share URLs.", style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}

class _TestsTab extends StatelessWidget {
  final List<TestItem> items;
  const _TestsTab({required this.items});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Upcoming Tests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        for (final t in items)
          Card(child: ListTile(
            title: Text(t.title),
            subtitle: Text("${t.subject} • ${t.grade} • ${t.durationMin} min • Max ${t.maxMarks}"),
            trailing: const Icon(Icons.launch),
            onTap: () => launchUrl(Uri.parse(t.formUrl), mode: LaunchMode.externalApplication),
          )),
        const SizedBox(height: 24),
        const Text("Tests open in Google Forms for now. Scores can be synced later.", style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}

class _DoubtsTab extends StatefulWidget {
  @override
  State<_DoubtsTab> createState() => _DoubtsTabState();
}

class _DoubtsTabState extends State<_DoubtsTab> {
  final controller = TextEditingController();
  String subject = "Mathematics";
  String grade = "Class 10";

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Doubt Box", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: DropdownButtonFormField(value: subject, items: const [
            DropdownMenuItem(value: "Mathematics", child: Text("Mathematics")),
            DropdownMenuItem(value: "Physics", child: Text("Physics")),
            DropdownMenuItem(value: "Chemistry", child: Text("Chemistry")),
            DropdownMenuItem(value: "Biology", child: Text("Biology")),
            DropdownMenuItem(value: "Business Studies", child: Text("Business Studies")),
            DropdownMenuItem(value: "Economics", child: Text("Economics")),
          ], onChanged: (v) => setState(() => subject = v as String))),
          const SizedBox(width: 12),
          Expanded(child: DropdownButtonFormField(value: grade, items: const [
            DropdownMenuItem(value: "Class 10", child: Text("Class 10")),
            DropdownMenuItem(value: "Class 11", child: Text("Class 11")),
            DropdownMenuItem(value: "Class 12", child: Text("Class 12")),
            DropdownMenuItem(value: "UG", child: Text("UG")),
            DropdownMenuItem(value: "PG", child: Text("PG")),
          ], onChanged: (v) => setState(() => grade = v as String))),
        ]),
        const SizedBox(height: 12),
        TextField(controller: controller, minLines: 3, maxLines: 5, decoration: const InputDecoration(hintText: "Type your doubt here…")),
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerRight, child: ElevatedButton(
          onPressed: () {
            if (controller.text.trim().isEmpty) return;
            context.read<AppState>().addDoubt(controller.text.trim(), subject, grade);
            controller.clear();
          },
          child: const Text("Submit"),
        )),
        const SizedBox(height: 20),
        const Text("Recent Doubts", style: TextStyle(fontWeight: FontWeight.w700)),
        for (final d in state.doubts)
          Card(child: ListTile(
            title: Text(d.text),
            subtitle: Text("${d.subject} • ${d.grade}"),
            trailing: d.answer == null ? const Text("Pending", style: TextStyle(color: Colors.orange)) : const Icon(Icons.check_circle, color: Colors.green),
          )),
      ],
    );
  }
}

class _ProgressTab extends StatelessWidget {
  final List<ScorePoint> points;
  const _ProgressTab({required this.points});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("My Progress", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.6,
          child: LineChart(LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                barWidth: 3,
                spots: [for (int i=0; i<points.length; i++) FlSpot(i.toDouble(), points[i].marks.toDouble())],
                dotData: const FlDotData(show: true),
              )
            ],
            minY: 0, maxY: 100,
          )),
        ),
      ],
    );
  }
}
