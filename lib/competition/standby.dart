import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Standby extends StatefulWidget {
  const Standby({Key? key}) : super(key: key);
  @override
  State<Standby> createState() => _StandbyState();
}

class _StandbyState extends State<Standby> {
  String situation = "対戦相手探し中";

  bool connect = false;

  // @override
  // void initState() {
  //   super.initState();
  //   var channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
  //   channel.stream.listen((event) {
  //     setState(() {
  //       connect = event;
  //     });
  //     channel.sink.add("receivec");
  //   });
  // }

  void _changeText() {
    setState(() {
      situation = "対戦相手が見つかりました";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('対戦待ち',
            style: TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.w700)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(situation,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
          CircularProgressIndicator(),
          ElevatedButton(onPressed: _changeText, child: Text("ボタン")),
        ],
      )),
    );
  }
}
