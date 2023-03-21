import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Inventory_Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Inventory');
class FirebaseCrud {
  static Future<Response> addProduct({
    required String productId,
    required String productName,
    required String uPrice,
    required String stock,
    required String weight,
    required String description,
     required String type,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "productId": productId,
      "productName": productName,
      "type" : type,
      "uPrice":uPrice,
      "weight":weight,
      "description":description,
      "stock":stock
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
          response.code = 200;
          response.message = "Product Deatils Added Sucessfully ";
        })
        .catchError((e) {
            response.code = 500;
            response.message = "Some Thing Went Wrong";
        });

        return response;
  }

    static Stream<QuerySnapshot> listProduct() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }
static Future<Response> updateProduct({
    required String productId,
    required String productName,
    required String uPrice,
    required String stock,
    required String weight,
    required String description,
     required String type,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "id": productId,
      "name": productName,
      "type" : type,
      "uniteprice":uPrice,
      "weight":weight,
      "description":description,
      "stock":stock
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Sucessfully updated the Product Details";
        })
        .catchError((e) {
            response.code = 500;
           response.message = "Some Thing Went Wrong";
        });

        return response;
  }

    static Future<Response> deleteProduct({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Sucessfully Deleted the Product Details";
        })
        .catchError((e) {
           response.code = 500;
            response.message = "Some Thing Went Wrong";
        });

   return response;
  }
}