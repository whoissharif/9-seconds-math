import 'package:flutter/foundation.dart';

class Level with ChangeNotifier {
  final int level;
  bool isLocked;

  Level({
    this.level,
    this.isLocked,
  });
}
