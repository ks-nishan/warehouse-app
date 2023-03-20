import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:warehouse_app/screens/employee_list.dart';

class NSplashScreen extends StatefulWidget {
  const NSplashScreen({super.key});

  @override
  State<NSplashScreen> createState() => _NSplashScreenState();
}

class _NSplashScreenState extends State<NSplashScreen> {
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 14);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (EmployeeList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.network(
            "https://assets2.lottiefiles.com/packages/lf20_jydkquj1.json"),
      ),
    );
  }
}
