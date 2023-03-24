import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warehouse_app/models/purchase.dart';
import 'package:warehouse_app/page/addpurchasePage.dart';
import 'package:warehouse_app/page/editpurchasePage.dart';
import 'package:flutter/material.dart';

import '../service/crudpurchase.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrud.readPurchases();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("All Purchase"),
        backgroundColor: Colors.yellow[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddPage(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    ListTile(
                      title: Text(e["PlistID"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("code: " + e['code'],
                                style: const TextStyle(fontSize: 16)),
                            Text("Pname: " + e['Pname'],
                                style: const TextStyle(fontSize: 16)),
                            Text("Pdate: " + e['Pdate'],
                                style: const TextStyle(fontSize: 16)),
                            Text("Unit: " + e['unit'],
                                style: const TextStyle(fontSize: 16)),
                            Text("Sname: " + e['Sname'],
                                style: const TextStyle(fontSize: 16)),
                            Text("Ddate: " + e['Ddate'],
                                style: const TextStyle(fontSize: 16)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.yellow[700],
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPage(
                                  purchase: Purchase(
                                      id: e.id,
                                      PlistID: e["PlistID"],
                                      code: e["code"],
                                      Pname: e["Pname"],
                                      Pdate: e["Pdate"],
                                      Qty: e["Qty"],
                                      unit: e["unit"],
                                      Sname: e["Sname"],
                                      Ddate: e["Ddate"]),
                                ),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.yellow[700],
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response =
                                await FirebaseCrud.deletePurchase(docId: e.id);
                            if (response.code != 200) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text(response.message.toString()),
                                    );
                                  });
                            }
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Color.fromARGB(255, 18, 18, 17),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('ADD'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
