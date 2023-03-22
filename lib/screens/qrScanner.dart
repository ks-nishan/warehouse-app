import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart'as scanner;
import 'package:flutter/material.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScanner();
}

class _QrScanner extends State<QrScanner> {
  String result="Scanned result";
  Future _qrscanner() async{
    var cammerStatus=await Permission.camera.status;

    if(cammerStatus.isGranted){
      String? qrdata=await scanner.scan();
      print(qrdata);
    }else{
      var isTrue=await Permission.camera.request();
      if(isTrue.isGranted){
        String? qrdata=await scanner.scan();
      print(qrdata);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(result), // Here the scanned result will be shown
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
           _qrscanner(); // calling a function when user click on button
          },
          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}