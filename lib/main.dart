import 'package:flutter/material.dart';
import 'package:mathmatics_quiz/models/categories.dart';
import 'package:provider/provider.dart';

import './screens/homepage.dart';
import './screens/quiz_page.dart';
import './screens/levels_page.dart';
import 'models/quiz_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: QuizList(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
      ],
      child: MaterialApp(
        
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Anton',
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrange,
        ),
        home: Homepage(),
        routes: {
          QuizPage.routeName: (ctx) => QuizPage(),
          LevelsPage.routeName: (ctx) => LevelsPage(),
        },
      ),
    );
  }
}
