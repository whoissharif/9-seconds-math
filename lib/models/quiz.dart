enum Complexity {
  basic,
  intermediate,
  advanced,
}

class Quiz {
  final String id;
  final String cid;
  final int level;
  final String question;
  final List<String> answers;
  final String rightAnser;
  final Complexity complexity;

  Quiz({
    this.id,
    this.cid,
    this.level,
    this.question,
    this.answers,
    this.rightAnser,
    this.complexity,
  });
}
