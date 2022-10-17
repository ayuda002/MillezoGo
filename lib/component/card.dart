import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Meishi_Card extends StatelessWidget {
  Meishi_Card({Key? key}) : super(key: key);

  Widget _card(
      BuildContext context, String url, Color color, Color body_color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 150,
      child: Card(
        color: color,
        child: Card(
          color: body_color,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 2, top: 5),
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 20,
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
                width: MediaQuery.of(context).size.width * 0.2,
                height: 80,
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
                height: 40,
                child: Text("10",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = [
      _card(
          context,
          "https://1.bp.blogspot.com/-vIXZ3_KMn9g/X-FcvVKPQSI/AAAAAAABdEc/i8oJKU0UDMM2uQfzemn6oOmJLICo4VcVgCNcBGAsYHQ/s400/onepiece10_jinbe.png",
          Colors.black,
          Colors.blueAccent),
      _card(
          context,
          "https://animeanime.jp/imgs/p/jtKDOVlKAvjRrNw8SXAVejagI61Nrq_oqaqr/378804.png",
          Colors.black,
          Colors.redAccent),
      _card(
          context,
          "https://1.bp.blogspot.com/-WoPLgzbefuw/X-FcxFa-YjI/AAAAAAABdE0/42S9V3wWi400mGKLEiB_pQT-dqTKT28kwCNcBGAsYHQ/s1156/onepiece14_enel.png",
          Colors.black,
          Colors.yellowAccent),
      _card(
          context,
          "https://1.bp.blogspot.com/-rzRcgoXDqEg/YAOTCKoCpPI/AAAAAAABdOI/5Bl3_zhOxm07TUGzW8_83cXMOT9yy1VJwCNcBGAsYHQ/s400/onepiece02_zoro_bandana.png",
          Colors.black,
          Colors.greenAccent),
      _card(
          context,
          "https://1.bp.blogspot.com/-JiNpsjnPn7g/X-FcuWcU37I/AAAAAAABdEQ/P5r3wBMTRegjl7njCk4zWBkdoay44-T2gCNcBGAsYHQ/s400/onepiece07_robin.png",
          Colors.black,
          Colors.purpleAccent),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Card一覧',
            style: TextStyle(
                color: Colors.lightBlue, fontWeight: FontWeight.w700)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      body: GridView.extent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.25,
          childAspectRatio: 0.6,
          // 1行あたりに表示するWidgetの数
          // Widget間のスペース（上下）
          mainAxisSpacing: 1,
          // Widget間のスペース（左右）ß
          crossAxisSpacing: 1,
          // 全体の余白
          padding: const EdgeInsets.all(8),
          children: list),
    );
  }
}
