import 'package:flutter/material.dart';
import 'package:mathmatics_quiz/constant.dart';
import 'package:mathmatics_quiz/models/categories.dart';
import 'package:mathmatics_quiz/models/quiz_list.dart';
import 'package:mathmatics_quiz/screens/levels_page.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  // List<String> cName = ['Beginer', 'Intermediate', 'Advanced'];
  Widget _buildItemButton(String name, Function onBtnTap) {
    return GestureDetector(
      onTap: onBtnTap,
      child: Container(
        height: 70,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
        child: Text(
          name,
          style: kCategoryButtonTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final quiz = Provider.of<QuizList>(context);
    final cat = Provider.of<Categories>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // alignment: Alignment.center,
              // child:
              children: <Widget>[
                Text(
                  'Play and',
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.deepOrange),
                ),
                Text(
                  'Boost Your Brain',
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Container(
            height: 330,
            child: ListView.builder(
                itemCount: cat.items.length,
                itemBuilder: (context, index) =>
                    _buildItemButton(cat.items[index].name, () {
                      Navigator.pushNamed(
                        context,
                        LevelsPage.routeName,
                        arguments: [
                          cat.items[index].id,
                          cat.items[index].name,
                        ],
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
