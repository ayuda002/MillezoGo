import 'package:flutter/material.dart';
import 'package:millezo_go/competition/nameplate.dart';

List<Widget> battle_items = [];

class Battle_Card extends StatefulWidget {
  const Battle_Card({Key? key}) : super(key: key);
  @override
  State<Battle_Card> createState() => _Battle_CardState();
}

class _Battle_CardState extends State<Battle_Card> {
  void test() {
    if (select_card != null) {
      setState(() {
        battle_items.add(_card(
            context, select_card["image"], Colors.black, Colors.blueAccent));
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  Widget _card(
      BuildContext context, String url, Color color, Color body_color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 210,
      child: Card(
        color: color,
        child: InkWell(
          onTap: test,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: battle_items,
      ),
    );
  }
}
