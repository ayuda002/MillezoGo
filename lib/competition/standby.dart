import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'competition.dart';

class Standby extends StatefulWidget {
  const Standby({Key? key}) : super(key: key);
  @override
  State<Standby> createState() => _StandbyState();
}

class _StandbyState extends State<Standby> {
  String situation = "対戦相手探し中";

  bool connect = false;

  String _text = '';

  dynamic channel;

  List<String> messages = [];

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(Uri.parse('ws://133.55.175.32:3000'));
    // channel.stream.listen((message) {
    //   setState(() {
    //     messages.add(message);
    //   });
    // });
  }

  @override
  void _changeText() {
    setState(() {
      situation = "対戦相手が見つかりました";
    });
    if (situation == "対戦相手が見つかりました") {}
  }

  void _sendMessage() {
    print("入力");
    channel.sink.add(_text);
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
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
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              decoration: InputDecoration(
                hintText: '名前を入力してください',
              ),
              enabled: true,
              // 入力数
              maxLength: 10,
              style: TextStyle(color: Colors.blue),
              obscureText: false,
              maxLines: 1,
              //パスワード
              onChanged: _handleText,
            ),
          ),
          ElevatedButton(
            child: const Text('ああ'),
            onPressed: _sendMessage,
          ),
          CircularProgressIndicator(),
          ElevatedButton(
              onPressed: () {
                _changeText();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Competition()),
                );
              },
              child: Text("ボタン")),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
        ],
      )),
    );
  }
}
