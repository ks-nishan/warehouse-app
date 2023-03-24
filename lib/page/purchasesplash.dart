import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:warehouse_app/page/addpurchasePage.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import '../page/viewlist.dart';

void main() => runApp(splashscreen());

class splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: Listview(),
          title: Text(
            'Welcome to My App',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: Image.network('https://i.imgur.com/TyCSG9A.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Flutter Splash"),
          loaderColor: Colors.red),
    );
  }
}
