import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:millezo_go/component/card.dart';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:millezo_go/competition/battle_card.dart';

dynamic snapshot;
dynamic card_data;
List hand_card = [];
List<Widget> battle_items = [];
List<Widget> items = [];
bool decision = false;
int select_key = 0;

dynamic select_card;

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);
  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  @override
  var _primarySwatch = Color.fromARGB(255, 48, 131, 226);

//firestoreからデータ取得
  void getImage() async {
    snapshot = await FirebaseFirestore.instance.collection("card").snapshots();
    if (snapshot != null) {
      snapshot.forEach((element) {
        element.docs.asMap().forEach((index, ele) {
          hand_card.add(ele.data());
          if (ele != null) {
            setState(() {
              items.add(_card(
                  context,
                  ele.data()["image"],
                  Colors.black,
                  Color(int.parse(ele.data()["color"])),
                  index,
                  ele.data()["name"],
                  ele.data()["fig"]));
            });
          }
          print("はい");
        });
      });
    }
  }

  //選択したカード
  void Select_Card(key) {
    items = [];
    select_card = hand_card[key];
    hand_card.removeAt(key);
    hand_card.asMap().forEach((index, value) {
      setState(() {
        items.add(_card(context, value["image"], Colors.black,
            Colors.blueAccent, index, value["name"], value["fig"]));
      });
    });
    battle();
  }

  //バトルカードをセット
  void battle() {
    setState(() {
      battle_items.add(_battle_card(
          context, select_card["image"], Colors.black, Colors.blueAccent));
    });
  }

  @override
  void initState() {
    super.initState();
    //アプリ起動時に一度だけ実行される
    getImage();
    battle_items = [];
  }

  Widget _hand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items,
    );
  }

  Widget _battle_card(
      BuildContext context, String url, Color color, Color body_color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 210,
      child: Card(
        color: color,
        child: InkWell(
          onTap: battle,
          child: Card(
            color: body_color,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2, top: 5 * 1.4),
                      width: MediaQuery.of(context).size.width * 0.15 * 1.4,
                      height: 20 * 1.4,
                      child: Text("TBB",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.04 * 1.4,
                        height: MediaQuery.of(context).size.width * 0.04 * 1.4,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_mizu_1.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2 * 1.4,
                  height: 60 * 1.4,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: body_color,
                          width: 3,
                        ),
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40 * 1.4,
                  child: Text("10",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context, String url, Color color, Color body_color,
      int key, String name, String fig) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 140,
      child: Card(
        key: ValueKey(key),
        color: color,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("最終確認"),
                  content: Text("タップしたカードを選択しますか？"),
                  actions: <Widget>[
                    // ボタン領域
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                      child: Text("NO"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      child: Text("YES"),
                      onPressed: () => {
                        setState(() {
                          decision = true;
                          select_key = key;
                        }),
                        Select_Card(key),
                        Navigator.pop(context),
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Card(
            color: body_color,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2, top: 5),
                      // width: MediaQuery.of(context).size.width * 0.1,
                      height: 15,
                      child: Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8)),
                    ),
                    // Container(
                    //     width: MediaQuery.of(context).size.width * 0.04,
                    //     height: MediaQuery.of(context).size.width * 0.04,
                    //     decoration: BoxDecoration(
                    //       color: color,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: Image.network(
                    //       "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_mizu_1.png",
                    //       fit: BoxFit.cover,
                    //     )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 60,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: body_color,
                          width: 3,
                        ),
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: Text(fig,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _battle() {
    return Container(
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: battle_items,
      ),
    );
  }

  Widget _partner() {
    return Container(
      width: double.infinity,
      color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text("AyudaiAAAAAAA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
          ),
          Container(
            width: 50,
            height: 50,
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
        ],
      ),
      // margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _MyProfile() {
    return Container(
      child: Column(children: <Widget>[
        Container(
          child: _hand(context),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          color: Colors.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
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
              Container(
                margin: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text("AyudaiAAAAAAA",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('対戦',
            style: TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.w700)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_partner(), _battle(), _MyProfile()],
      ),
    );
  }
}
