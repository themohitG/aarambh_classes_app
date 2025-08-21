import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../models/models.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});
  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int index = 0; // 0 Lesson, 1 Upload, 2 Create Test, 3 Doubts, 4 Analytics
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text("AARAMBH – Teacher")),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), label: "Lesson"),
          NavigationDestination(icon: Icon(Icons.upload_file), label: "Upload"),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), label: "Create Test"),
          NavigationDestination(icon: Icon(Icons.question_answer_outlined), label: "Doubts"),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), label: "Analytics"),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: [
          _LessonTab(),
          _UploadTab(),
          _CreateTestTab(),
          _AnswerDoubtsTab(),
          _AnalyticsTab(),
        ],
      ),
    );
  }
}

class _LessonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final objectives = TextEditingController();
    final activities = TextEditingController();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Quick Lesson Planner", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        TextField(controller: objectives, minLines: 4, maxLines: 8, decoration: const InputDecoration(hintText: "Learning objectives…")),
        const SizedBox(height: 12),
        TextField(controller: activities, minLines: 4, maxLines: 8, decoration: const InputDecoration(hintText: "Activities / Examples / Homework…")),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text("Save Plan")),
      ],
    );
  }
}

class _UploadTab extends StatefulWidget {
  @override
  State<_UploadTab> createState() => _UploadTabState();
}

class _UploadTabState extends State<_UploadTab> {
  String subject = "Mathematics"; String grade = "Class 10"; String type = "PDF";
  final title = TextEditingController(); final link = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Upload Resource", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        TextField(controller: title, decoration: const InputDecoration(hintText: "Title (e.g., Derivatives – Formula Sheet)")),
        const SizedBox(height: 12),
        TextField(controller: link, decoration: const InputDecoration(hintText: "Google Drive / YouTube / File URL")),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: DropdownButtonFormField(value: grade, items: const [
            DropdownMenuItem(value: "Class 10", child: Text("Class 10")), DropdownMenuItem(value: "Class 11", child: Text("Class 11")),
            DropdownMenuItem(value: "Class 12", child: Text("Class 12")), DropdownMenuItem(value: "UG", child: Text("UG")), DropdownMenuItem(value: "PG", child: Text("PG")),
          ], onChanged: (v) => setState(() => grade = v as String))),
          const SizedBox(width: 12),
          Expanded(child: DropdownButtonFormField(value: subject, items: const [
            DropdownMenuItem(value: "Mathematics", child: Text("Mathematics")), DropdownMenuItem(value: "Physics", child: Text("Physics")),
            DropdownMenuItem(value: "Chemistry", child: Text("Chemistry")), DropdownMenuItem(value: "Biology", child: Text("Biology")),
            DropdownMenuItem(value: "Business Studies", child: Text("Business Studies")), DropdownMenuItem(value: "Economics", child: Text("Economics")),
          ], onChanged: (v) => setState(() => subject = v as String))),
        ]),
        const SizedBox(height: 12),
        DropdownButtonFormField(value: type, items: const [
          DropdownMenuItem(value: "PDF", child: Text("PDF")), DropdownMenuItem(value: "Slides", child: Text("Slides")),
          DropdownMenuItem(value: "Video", child: Text("Video")), DropdownMenuItem(value: "Link", child: Text("Link")),
        ], onChanged: (v) => setState(() => type = v as String)),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {
          if (title.text.trim().isEmpty) return;
          state.addResource(ResourceItem(title: title.text.trim(), subject: subject, grade: grade, type: type, url: link.text.trim()));
          title.clear(); link.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Resource added (mock). Replace with Drive API later.")));
        }, child: const Text("Add Resource")),
        const SizedBox(height: 16),
        const Text("Recent Resources"),
        for (final r in state.resources)
          Card(child: ListTile(title: Text(r.title), subtitle: Text("${r.subject} • ${r.grade} • ${r.type}"))),
      ],
    );
  }
}

class _CreateTestTab extends StatefulWidget {
  @override
  State<_CreateTestTab> createState() => _CreateTestTabState();
}

class _CreateTestTabState extends State<_CreateTestTab> {
  String subject = "Mathematics"; String grade = "Class 10";
  final title = TextEditingController();
  final formUrl = TextEditingController();
  int duration = 30; int maxMarks = 50;
  DateTime date = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Create Test", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        TextField(controller: title, decoration: const InputDecoration(hintText: "Title (e.g., Limits – MCQ)")),
        const SizedBox(height: 12),
        TextField(controller: formUrl, decoration: const InputDecoration(hintText: "Google Form URL")),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: DropdownButtonFormField(value: grade, items: const [
            DropdownMenuItem(value: "Class 10", child: Text("Class 10")), DropdownMenuItem(value: "Class 11", child: Text("Class 11")),
            DropdownMenuItem(value: "Class 12", child: Text("Class 12")), DropdownMenuItem(value: "UG", child: Text("UG")), DropdownMenuItem(value: "PG", child: Text("PG")),
          ], onChanged: (v) => setState(() => grade = v as String))),
          const SizedBox(width: 12),
          Expanded(child: DropdownButtonFormField(value: subject, items: const [
            DropdownMenuItem(value: "Mathematics", child: Text("Mathematics")), DropdownMenuItem(value: "Physics", child: Text("Physics")),
            DropdownMenuItem(value: "Chemistry", child: Text("Chemistry")), DropdownMenuItem(value: "Biology", child: Text("Biology")),
            DropdownMenuItem(value: "Business Studies", child: Text("Business Studies")), DropdownMenuItem(value: "Economics", child: Text("Economics")),
          ], onChanged: (v) => setState(() => subject = v as String))),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextFormField(initialValue: duration.toString(), decoration: const InputDecoration(labelText: "Duration (min)"),
            onChanged: (v) => duration = int.tryParse(v) ?? 30)),
          const SizedBox(width: 12),
          Expanded(child: TextFormField(initialValue: maxMarks.toString(), decoration: const InputDecoration(labelText: "Max Marks"),
            onChanged: (v) => maxMarks = int.tryParse(v) ?? 50)),
        ]),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {
          if (title.text.trim().isEmpty || formUrl.text.trim().isEmpty) return;
          state.addTest(TestItem(title: title.text.trim(), subject: subject, grade: grade, durationMin: duration, maxMarks: maxMarks, date: date, formUrl: formUrl.text.trim()));
          title.clear(); formUrl.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Test published (mock). Students will open the Form link.")));
        }, child: const Text("Publish Test")),
        const SizedBox(height: 16),
        const Text("Upcoming Tests"),
        for (final t in state.tests)
          Card(child: ListTile(title: Text(t.title), subtitle: Text("${t.subject} • ${t.grade} • ${t.durationMin} min • Max ${t.maxMarks}"))),
      ],
    );
  }
}

class _AnswerDoubtsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Answer Doubts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        for (final d in state.doubts)
          Card(child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${d.subject} • ${d.grade}", style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(d.text),
              const SizedBox(height: 8),
              TextFormField(initialValue: d.answer ?? "", minLines: 2, maxLines: 6, decoration: const InputDecoration(hintText: "Type your answer…"),
                onChanged: (v) => state.answerDoubt(d, v)),
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerRight, child: ElevatedButton(onPressed: () {}, child: const Text("Post Answer"))),
            ]),
          )),
      ],
    );
  }
}

class _AnalyticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sample = [
      ("Chapter 1", 62), ("Chapter 2", 71), ("Chapter 3", 55), ("Chapter 4", 78), ("Chapter 5", 66),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Performance Analytics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        for (final row in sample)
          Card(child: ListTile(title: Text(row.$1), trailing: Text("${row.$2}%"))),
        const SizedBox(height: 8),
        const Text("Hook this to Google Sheets/Forms results or Firestore later.", style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}
