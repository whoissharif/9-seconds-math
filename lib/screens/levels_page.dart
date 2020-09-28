import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/quiz_page.dart';
import '../models/quiz_category.dart';
import '../models/quiz_list.dart';
import '../models/categories.dart';

class LevelsPage extends StatefulWidget {
  static const routeName = 'levels-page';
  final String title;
  LevelsPage({this.title});

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  String cname;
  String cid;
  List selectedCategory;
  // Levels level;
  QuizCategory category;
  var _loadedInitData = false;
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final args = ModalRoute.of(context).settings.arguments as List;
      cid = args[0];
      cname = args[1];
      // final level = args[1];
      category = Provider.of<Categories>(context).findByCid(cid);
      selectedCategory = Provider.of<QuizList>(context).findByCid(cid);
      // level = Provider.of<Levels>(context);
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
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
        itemCount: category.levelList.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: category.levelList[i].isLocked == false
                ? () {
                    Navigator.pushNamed(
                      context,
                      QuizPage.routeName,
                      arguments: [
                        category.levelList[i].level,
                        selectedCategory[i].complexity,
                        cid,
                        cname,
                        // level.items[i].isComplete,
                        // level.items[i+1].isLocked,
                      ],
                    ).then(
                      (value) {
                        if (value == null) return;
                        if (value) {
                          setState(() {
                            if (i + 1 < category.levelList.length) {
                              category.levelList[i + 1].isLocked = false;
                            }
                          });
                        }
                      },
                    );
                  }
                : null,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (category.levelList[i].isLocked == false)
                    ? Colors.deepOrange
                    : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
