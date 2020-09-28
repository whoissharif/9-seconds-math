import 'package:mathmatics_quiz/models/level.dart';

class QuizCategory {
  final String id;
  final String name;
  final List<Level> levelList;
  bool isLocked;

  QuizCategory({
    this.id,
    this.name,
    this.levelList,
    this.isLocked,
  });
}
