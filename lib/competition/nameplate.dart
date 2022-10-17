import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:millezo_go/competition/battle_card.dart';

dynamic snapshot;
dynamic card_data;
List hand_card = [];
List<Widget> items = [];
bool decision = false;
int select_key = 0;

dynamic select_card;

class Nameplate extends StatefulWidget {
  const Nameplate({Key? key}) : super(key: key);
  @override
  State<Nameplate> createState() => _NameplateState();
}

class _NameplateState extends State<Nameplate> {
  // void getAPI() async {
  //   var url = Uri.parse(
  //       'https://umayadia-apisample.azurewebsites.net/api/persons/Shakespeare');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> user =
  //         jsonDecode(utf8.decode(response.body.runes.toList()));
  //     print(user["data"]["name"]);
  //   }
  //   print(response.statusCode);
  // }

//Firestoreとの連携

  void getImage() async {
    snapshot = await FirebaseFirestore.instance.collection("card").snapshots();
    if (snapshot != null) {
      snapshot.forEach((element) {
        element.docs.asMap().forEach((index, ele) {
          hand_card.add(ele.data());
          if (ele != null) {
            setState(() {
              items.add(_card(context, ele.data()["image"], Colors.black,
                  Colors.blueAccent, index));
            });
          }
          print("はい");
        });
      });
    }
  }

  void Select_Card(key) {
    // setState(() {
    //   battle_items.add(_card(
    //       context, select_card["image"], Colors.black, Colors.blueAccent, 1));
    // });
    // print(items);
    items = [];
    hand_card.removeAt(key);
    hand_card.asMap().forEach((index, value) {
      setState(() {
        items.add(_card(
            context, value["image"], Colors.black, Colors.blueAccent, index));
      });
    });
  }

  Widget _test(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items,
    );
  }

  Widget _card(BuildContext context, String url, Color color, Color body_color,
      int key) {
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
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: 15,
                      child: Text("TBB",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
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
                  child: Text("10",
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

  @override
  void initState() {
    super.initState();
    //アプリ起動時に一度だけ実行される
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _test(context),
    );
  }
}
