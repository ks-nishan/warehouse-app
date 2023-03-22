import 'package:warehouse_app/screens/authenticate/login.dart';
import 'package:warehouse_app/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Handler extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Handler();
  }
}

class _Handler extends State<Handler> {
  bool showSignin = true;

  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
