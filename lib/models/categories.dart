import 'package:flutter/foundation.dart';
import 'package:mathmatics_quiz/models/level.dart';
import 'package:mathmatics_quiz/models/quiz_category.dart';

class Categories with ChangeNotifier {
  final List<QuizCategory> _items = [
    QuizCategory(
      id: 'c1',
      name: 'Beginer',
      isLocked: false,
      levelList: [
        Level(level: 1, isLocked: false),
        Level(level: 2),
        Level(level: 3),
        Level(level: 4),
        Level(level: 5),
      ],
    ),
    QuizCategory(
      id: 'c2',
      name: 'Intermediate',
      levelList: [
        Level(level: 1, isLocked: false),
        Level(level: 2),
        Level(level: 3),
        Level(level: 4),
        Level(level: 5),
      ],
    ),
    QuizCategory(
      id: 'c3',
      name: 'Advanced',
      levelList: [
        Level(level: 1, isLocked: false),
        Level(level: 2),
        Level(level: 3),
        Level(level: 4),
        Level(level: 5),
      ],
    ),
  ];

  List<QuizCategory> get items {
    return [..._items];
  }

  QuizCategory findByCid(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
