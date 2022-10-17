import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:millezo_go/competition/battle_card.dart';
import 'package:millezo_go/component/card.dart';
import 'package:millezo_go/competition/nameplate.dart';

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);
  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  @override
  var _primarySwatch = Color.fromARGB(255, 48, 131, 226);

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
        ],
      ),
      // margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _MyProfile() {
    return Container(
      child: Column(children: <Widget>[
        Nameplate(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          color: Colors.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
        children: <Widget>[_partner(), _MyProfile()],
      ),
    );
  }
}
