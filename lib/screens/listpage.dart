import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:warehouse_app/models/supplier.dart';
import 'package:warehouse_app/screens/addpage.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/editpage.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/services/auth.dart';
import '../services/firebase_crud.dart';
import 'authenticate/login.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readSupplier();
  //FirebaseFirestore.instance.collection('Employee').snapshots();
  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: collectionReference,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // Expanded(
            //   child: TabBarView(controller: controller, children: const [
            //     Dashboard(),
            //     AddPage(),
            //     ListPage(),
            //   ]),
            // );
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Card(
                        child: Column(children: [
                      ListTile(
                        leading: Image.asset("assets/icons/supplier.png"),
                        title: Text(e["name"],
                            style: const TextStyle(fontSize: 24)),
                        subtitle: Container(
                          child: (Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Email: " + e['email'],
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 2, 2, 2))),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Contact Number: " + e['phone'],
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 2, 2, 2))),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Address: " + e['address'],
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 2, 2, 2))),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text("Product: " + e['product'],
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 2, 2, 2))),
                            ],
                          )),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 127, 127, 8),
                              padding: const EdgeInsets.all(5.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text('Edit'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => EditPage(
                                    supplier: Supplier(
                                        uid: e.id,
                                        name: e["name"],
                                        email: e["email"],
                                        phone: e["phone"],
                                        address: e["address"],
                                        product: e["product"]),
                                  ),
                                ),
                                (route) =>
                                    false, //if you want to disable back feature set to false
                              );
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(5.0),
                              primary: const Color.fromARGB(255, 127, 127, 8),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text('Delete'),
                            onPressed: () async {
                              var response = await FirebaseCrud.deleteSupplier(
                                  docId: e.id);
                              if (response.code != 200) {
                                // ignore: use_build_context_synchronously
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
                        ],
                      ),
                    ]));
                  }).toList(),
                ),
              );
            }

            return Container();
          },
        ));
  }
}
