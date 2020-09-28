import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/categories.dart';
import '../screens/levels_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final cat = Provider.of<Categories>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Play and',
                  style: TextStyle(
                      fontSize: 20, letterSpacing: 1, color: Colors.deepOrange),
                ),
                Text(
                  'Boost Your Brain',
                  style: TextStyle(
                      fontSize: 20, letterSpacing: 1, color: Colors.deepOrange),
                ),
              ],
            ),
          ),
          Container(
            height: 330,
            child: ListView.builder(
              itemCount: cat.items.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: cat.items[index].isLocked == false
                    ? () {
                        Navigator.pushNamed(
                          context,
                          LevelsPage.routeName,
                          arguments: [
                            cat.items[index].id,
                            cat.items[index].name,
                          ],
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              //checking if the previous category is complete or not
                              if (cat.items[index].levelList[4].isLocked ==
                                  false) {
                                cat.items[index + 1].isLocked = false;
                              }
                            });
                          }
                        });
                      }
                    : null,
                child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          cat.items[index].name,
                          style: kCategoryButtonTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          cat.items[index].isLocked == false
                              ? Icons.play_arrow
                              : Icons.lock,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
