import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);
  @override
  State<Competition> createState() => _CompetitionState();
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.0),
      color: Colors.white70,
      child: Text('Widget A'),
    );
  }
}

class _CompetitionState extends State<Competition> {
  @override
  var _primarySwatch = Color.fromARGB(255, 48, 131, 226);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Card一覧',
            style: TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.w700)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                Container(
                  // width: 400,
                  // margin: EdgeInsets.only(top: ),
                  height: 150,
                  width: double.infinity,
                  color: Colors.orange,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://dnsk.jp/wp/wp-content/uploads/2018/05/blog_01.jpg"),
                        ),
                      ),
                    ),
                  ),
                  // margin: const EdgeInsets.only(bottom: 20),
                ),
              ],
            ),
          ),
          Align(
            child: Text("はい"),
          ),
          Align(
            alignment: const Alignment(0, 0.55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, //色
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, //色
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, //色
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Stack(
              children: [
                Container(
                  // width: 400,
                  height: 130,
                  color: Colors.orange,
                  // margin: const EdgeInsets.only(bottom: 20),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://dnsk.jp/wp/wp-content/uploads/2018/05/blog_01.jpg"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
