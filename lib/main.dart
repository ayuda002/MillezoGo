import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'competition/competition.dart';
import 'package:image_picker/image_picker.dart';
import 'component/card.dart';
import 'competition/standby.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MillezoGo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MillezoGo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  final picker = ImagePicker();

  Future getImage() async {
    try {
      final photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        File image = File(photo.path);
        String uploadName = 'image.png';
        final storageRef = FirebaseStorage.instance.ref().child("images");
        final task = await storageRef.child(uploadName).putFile(image);
      }
      // print(photo.path);
    } on PlatformException catch (e) {
      print('Faield: &e');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _battleButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade600,
            Colors.blue.shade400
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Standby()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '対戦',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 185,
                  child: Image.asset(
                    'images/battle.png',
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            )),
      ),
    );
  }

  Widget _cardButton(String text, String image_path, var page) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent.shade700,
            Colors.lightBlueAccent.shade400,
            Colors.lightBlueAccent.shade200
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 100,
                  child: Image.asset(
                    image_path,
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            )),
      ),
    );
  }

  Widget _captionButton(String text, String image_path, var page) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent.shade700,
            Colors.lightBlueAccent.shade400,
            Colors.lightBlueAccent.shade200
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: page,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 100,
                  child: Image.asset(
                    image_path,
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _battleButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _cardButton("Card一覧", 'images/card.png', Meishi_Card()),
                _captionButton("スキャン", 'images/scan.png', getImage),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Competition()),
                );
              },
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: const Text('BUTTON'),
            ),
            // Meishi_Card(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
