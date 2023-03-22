import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warehouse_app/screens/productSingleList.dart';
import '../screens/Edit_Product.dart';
import '../models/product.dart';
import '../screens/add_product.dart';
import 'package:flutter/material.dart';

import '../service/Inventory_Service.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.listProduct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("List of Products"),
        backgroundColor: Theme.of(context).primaryColor,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.file_copy_outlined,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.pushAndRemoveUntil<dynamic>(
        //         context,
        //         MaterialPageRoute<dynamic>(
        //           builder: (BuildContext context) => Add_product(),
        //         ),
        //         (route) =>
        //             false, 
        //       );
        //     },
        //   )
        // ],
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
                          ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text(''),
                          onPressed: () async {
                           
                          },
                        ),
                          IconButton(
            icon: Icon(
              Icons.file_copy_outlined,
              color:const Color.fromARGB(255, 143, 133, 226),
            ),
            onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => AllProduct(
                                  product: Product(
                                      productId: e.id,
                                      productName: e["productName"],
                                      description: e["description"],
                                     type: e["type"],
                                       uPrice:e["uPrice"],
                                       stock: e["stock"],
                                       weight:e["weight"],
                                       ),
                                     
                                   
                                ),
                              ),
                              (route) =>
                                  false, 
                            );
                          },
          )
                      ],
                    ),
                    ListTile(
                      title: Text(e["productName"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                Text("Type: " + e['type'],
                                style: const TextStyle(fontSize: 20)),
                                 Text("Description: " + e['description'],
                                style: const TextStyle(fontSize: 20)),
                                 Text("Stock: " + e['stock'],
                                style: const TextStyle(fontSize: 20)),
                                
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
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPage(
                                  product: Product(
                                    id: e.id,
                                    productId: e["productId"],
                                      productName: e["productName"],
                                      description: e["description"],
                                     type: e["type"],
                                     weight: e["weight"],
                                     uPrice: e["uPrice"],
                                     stock: e["stock"]),
                                ),
                              ),
                              (route) =>
                                  false, 
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response =
                                await FirebaseCrud.deleteProduct(docId: e.id);
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