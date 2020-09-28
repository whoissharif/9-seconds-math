import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathmatics_quiz/models/quiz_list.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  static const routeName = 'quiz-page';

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var _levelIndex = 0;
  var cid;
  var cname;
  int _coin = 5;
  bool _timerPaused = false;

  void _answered() {
    setState(() {
      _levelIndex = _levelIndex + 1;
      _startTimer();

      _timerPaused = false;
    });
  }

  Timer timer;
  int startingTime = 10;

  void _pauseTimer() {
    if (timer != null) {
      timer.cancel();
      // timer = null;
    } else {
      // timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      //   setState(() {
      //     if (startingTime < 1) {
      //       t.cancel();
      //     } else {
      //       startingTime = startingTime - 1;
      //     }
      //   });
      // });
      return;
    }
  }

  void _startTimer() {
    if (timer != null) {
      timer.cancel();
      startingTime = 10;
    }
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (startingTime < 1) {
          t.cancel();
        } else {
          startingTime = startingTime - 1;
        }
      });
    });
  }

  @override
  void initState() {
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Widget _buildAnsBtn(String ansText) {
  //   return FloatingActionButton(
  //     heroTag: null,
  //     backgroundColor: Colors.deepOrange,
  //     foregroundColor: Colors.white,
  //     onPressed: () {
  //       _answered();
  //     },
  //     child: Text(ansText),
  //   );
  // }

  // void _dialog(BuildContext c) {
  //   showDialog(
  //     context: c,
  //     builder: (context) => AlertDialog(
  //       title: Text('Oops !'),
  //       content: Text('You didn\'t make it'),
  //       actions: <Widget>[
  //         FlatButton(
  //           onPressed: () {},
  //           child: Text('Cancel'),
  //         ),
  //         FlatButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //             // popAndPushNamed(LevelsPage.routeName, arguments: [cid,cname]);
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('Ok'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final level = args[0];
    final complexity = args[1];
    cid = args[2];
    cname = args[3];
    final selectedLevel =
        Provider.of<QuizList>(context).findByLevel(level, complexity);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (startingTime < 1) {
        // _dialog(context);
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      body: _levelIndex < selectedLevel.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.copyright,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$_coin',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // color: Colors.black54,
                        ),
                    // child: Text(
                    //   selectedLevel[_levelIndex].question,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.deepOrange,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),

                    // child: DefaultTextStyle.merge(
                    //   child: CaTeX('${selectedLevel[_levelIndex].question}'),
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.deepOrange,
                    //   ),
                    // ),
                    child: RichText(
                        text: TextSpan(
                      text: "${selectedLevel[_levelIndex].question}",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _coin < 1
                            ? null
                            : () {
                                _pauseTimer();
                                setState(() {
                                  _coin--;
                                  _timerPaused = true;
                                });
                              },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '$startingTime',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    's',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              ),
                              Icon(
                                _timerPaused == false
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _timerPaused == false
                                ? Colors.deepOrange
                                : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ...selectedLevel[_levelIndex].answers.map(
                        (answer) {
                          // return _buildAnsBtn(answer);
                          return FloatingActionButton(
                            heroTag: null,
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              answer == selectedLevel[_levelIndex].rightAnser
                                  ? _answered()
                                  : Navigator.of(context).pop();
                            },
                            child: Text(answer),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${_levelIndex + 1} / ${selectedLevel.length}',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.amber,
                        onPressed: _coin < 1
                            ? null
                            : () {
                                setState(() {
                                  _coin--;
                                  _answered();
                                  _startTimer();
                                  _timerPaused = false;
                                });
                              },
                        child: Text('Skip'),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have completed this level'),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    onPressed: () {
                      // setState(
                      //   () {
                      //     if (level < category.levelList.length) {
                      //       // levels.items[level].isLocked = false;
                      //       category.levelList[level].isLocked = false;
                      //     }
                      //   },
                      // );

                      Navigator.pop(context, true);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
    );
  }
}
