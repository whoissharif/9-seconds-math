import 'package:flutter/material.dart';
import 'package:mathmatics_quiz/models/quiz_list.dart';
import 'package:provider/provider.dart';
import '../screens/quiz_page.dart';

class LevelsPage extends StatelessWidget {
  static const routeName = 'levels-page';
  final String title;
  LevelsPage({this.title});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final cid = args[0];
    final cname = args[1];
    // final level = args[1];
    final selectedCategory = Provider.of<QuizList>(context).findByCid(cid);

    return Scaffold(
      appBar: AppBar(
        title: Text(cname),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.copyright),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '7',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          //childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        /**  ---------------------------------------------
         * itemcount should be the maximum level of each category 
         * ----------------------------------------------- **/
        itemCount: 5,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                QuizPage.routeName,
                arguments: [
                  i + 1,
                  selectedCategory[i].complexity,
                  cid,
                  cname,
                ],
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
