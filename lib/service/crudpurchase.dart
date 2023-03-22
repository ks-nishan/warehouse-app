import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Purchase');

class FirebaseCrud {
  static Future<Response> addPurchase({
    required String PlistID,
    required String code,
    required String Pname,
    required String Pdate,
    required String Qty,
    required String unit,
    required String Sname,
    required String Ddate,

    //required String PlistID,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "PlistID": PlistID,
      "code": code,
      "Pname": Pname,
      "Pdate": Pdate,
      "Qty": Qty,
      "unit": unit,
      "Sname": Sname,
      "Ddate": Ddate
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readPurchases() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updatePurchase({
    required String PlistID,
    required String code,
    required String Pname,
    required String Pdate,
    required String Qty,
    required String unit,
    required String Sname,
    required String Ddate,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "PlistID": PlistID,
      "code": code,
      "Pname": Pname,
      "Pdate": Pdate,
      "Qty": Qty,
      "unit": unit,
      "Sname": Sname,
      "Ddate": Ddate
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated the Purchase";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deletePurchase({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
