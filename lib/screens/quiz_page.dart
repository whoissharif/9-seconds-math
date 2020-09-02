import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathmatics_quiz/models/quiz_list.dart';
import 'package:mathmatics_quiz/screens/levels_page.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  static const routeName = 'quiz-page';

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var _levelIndex = 0;

  void _answered() {
    setState(() {
      _levelIndex = _levelIndex + 1;
    });
  }

  Timer timer;
  int startingTime = 10;

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

  Widget _buildAnsBtn(String ansText) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      onPressed: () {
        _answered();
        _startTimer();
      },
      child: Text(ansText),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final level = args[0];
    final complexity = args[1];
    final cid = args[2];
    final cname = args[3];
    final selectedLevel =
        Provider.of<QuizList>(context).findByLevel(level, complexity);
    void _dialog(BuildContext c) {
      showDialog(
        context: c,
        builder: (c) => AlertDialog(
          title: Text('Oops !'),
          content: Text('You didn\'t make it'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(c).pop();
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
                                                                                                                             
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (startingTime < 1) {
        _dialog(context);
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
                          Icon(Icons.copyright,color: Colors.amber,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '7',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.amber
                            ),
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
                  child: Text(
                    selectedLevel[_levelIndex].question,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
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
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  's',
                                  style: TextStyle(fontSize: 18,color: Colors.white),
                                )
                              ],
                            ),
                            Icon(Icons.pause, color: Colors.white,),
                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // _buildAnsBtn(),
                      // SizedBox(width: 15),
                      // _buildAnsBtn(),
                      // SizedBox(width: 15),
                      // _buildAnsBtn(),
                      ...selectedLevel[_levelIndex].answers.map(
                        (answer) {
                          return _buildAnsBtn(answer);
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
                      child:
                          Text('${_levelIndex + 1} / ${selectedLevel.length}',style: TextStyle(
                            color: Colors.amber
                          ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.amber,
                        onPressed: () {},
                        child: Text('Skip'),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: Text('You Have Completed this level'),
            ),
    );
  }
}
