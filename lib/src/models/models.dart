class ResourceItem {
  final String title;
  final String subject;
  final String grade;
  final String type;
  final String url;
  ResourceItem({required this.title, required this.subject, required this.grade, required this.type, required this.url});
}

class TestItem {
  final String title;
  final String subject;
  final String grade;
  final int durationMin;
  final int maxMarks;
  final DateTime date;
  final String formUrl; // Google Form link
  TestItem({required this.title, required this.subject, required this.grade, required this.durationMin, required this.maxMarks, required this.date, required this.formUrl});
}

class Doubt {
  final String text;
  final String subject;
  final String grade;
  String? answer;
  Doubt({required this.text, required this.subject, required this.grade, this.answer});
}

class ScorePoint {
  final String label;
  final int marks;
  ScorePoint({required this.label, required this.marks});
}
