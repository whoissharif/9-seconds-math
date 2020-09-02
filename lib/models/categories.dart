import 'package:flutter/foundation.dart';
import 'package:mathmatics_quiz/models/quiz_category.dart';

class Categories with ChangeNotifier {
  final List<QuizCategory> _items = [
    QuizCategory(
      id: 'c1',
      name: 'Beginer',
    ),
    QuizCategory(
      id: 'c2',
      name: 'Intermediate',
    ),
    QuizCategory(
      id: 'c3',
      name: 'Advanced',
    ),
  ];

  List<QuizCategory> get items {
    return [..._items];
  }
}
