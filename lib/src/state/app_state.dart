import 'package:flutter/material.dart';
import '../models/models.dart';

class AppState extends ChangeNotifier {
  String displayName = "Student";
  List<ResourceItem> resources = [];
  List<TestItem> tests = [];
  List<Doubt> doubts = [];
  List<ScorePoint> scores = [];

  void bootstrap() {
    // Mock data
    resources = [
      ResourceItem(title: "Quadratic Equations – Formula Sheet", subject: "Mathematics", grade: "Class 10", type: "PDF", url: "https://drive.google.com/"),
      ResourceItem(title: "Organic Chemistry – Hydrocarbons", subject: "Chemistry", grade: "Class 11", type: "PDF", url: "https://drive.google.com/"),
      ResourceItem(title: "Vectors for Engineers (Slides)", subject: "Mathematics", grade: "UG", type: "Slides", url: "https://drive.google.com/"),
    ];
    tests = [
      TestItem(title: "Algebra Basics (MCQ)", subject: "Mathematics", grade: "Class 8", maxMarks: 30, durationMin: 30, date: DateTime.now().add(const Duration(days: 3)), formUrl: "https://forms.google.com/"),
      TestItem(title: "Thermodynamics – Quiz", subject: "Physics", grade: "Class 11", maxMarks: 40, durationMin: 40, date: DateTime.now().add(const Duration(days: 5)), formUrl: "https://forms.google.com/"),
    ];
    doubts = [
      Doubt(text: "What is the discriminant formula?", subject: "Mathematics", grade: "Class 10", answer: "b² − 4ac. If > 0 two roots; =0 one root; <0 complex."),
    ];
    scores = [
      ScorePoint(label: "Test 1", marks: 58),
      ScorePoint(label: "Test 2", marks: 67),
      ScorePoint(label: "Test 3", marks: 72),
      ScorePoint(label: "Test 4", marks: 81),
      ScorePoint(label: "Test 5", marks: 76),
    ];
  }

  void addDoubt(String text, String subject, String grade) {
    doubts.insert(0, Doubt(text: text, subject: subject, grade: grade));
    notifyListeners();
  }

  void answerDoubt(Doubt d, String answer) {
    d.answer = answer;
    notifyListeners();
  }

  void addResource(ResourceItem r) {
    resources.insert(0, r);
    notifyListeners();
  }

  void addTest(TestItem t) {
    tests.insert(0, t);
    notifyListeners();
  }
}
