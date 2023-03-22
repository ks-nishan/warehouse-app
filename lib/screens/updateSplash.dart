import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:warehouse_app/screens/employee_list.dart';

class UpdateSplash extends StatefulWidget {
  const UpdateSplash({super.key});

  @override
  State<UpdateSplash> createState() => _UpdateSplashState();
}

class _UpdateSplashState extends State<UpdateSplash> {
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 10);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (EmployeeList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: content(),
    );
  }

  Widget content() {
    return Stack(
      children: [
        Center(
          child: Container(
            child: Lottie.network(
                "https://assets5.lottiefiles.com/private_files/lf30_rzhdjuoe.json"),
          ),
        ),
        // const Center(
        //   child: Text(
        //     "Employee Updated!",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 24,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
