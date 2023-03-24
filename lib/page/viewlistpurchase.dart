import 'package:flutter/material.dart';
import 'package:warehouse_app/page/addpurchasePage.dart';

void main() {
  runApp(MaterialApp(
    home: Listview(),
  ));
}

class Listview extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Listview> {
  final List<String> names = <String>[
    'Clothing Garments',
    'Health & Beauty',
    'Home & Lifestyle',
    'Watches & Accessories',
    'Sports & Outdoor',
    'Eyewear & Accessories',
    'Fashion Accessories',
    'Clothing Garments',
    "Home Appliances",
    "Electronic Devices"
  ];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2, 1, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[700],
        appBar: AppBar(
          title: Text('Purchase'),
          backgroundColor: Colors.yellow[700],
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.all(2),
                          color: msgCount[index] >= 10
                              ? Color.fromARGB(255, 255, 255, 255)
                              : msgCount[index] > 3
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 255, 255),
                          child: Center(
                              child: Text(
                            '${names[index]} ',
                            style: TextStyle(fontSize: 18),
                          )),
                        ));
                  }))
        ]));
  }
}
