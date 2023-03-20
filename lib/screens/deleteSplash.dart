import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:warehouse_app/screens/employee_list.dart';

class DeleteSplash extends StatefulWidget {
  const DeleteSplash({super.key});

  @override
  State<DeleteSplash> createState() => _DeleteSplashState();
}

class _DeleteSplashState extends State<DeleteSplash> {
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (EmployeeList())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: content(),
    );
  }

  Widget content() {
    return Stack(
      children: [
        Center(
          child: Container(
            child: Lottie.network(
                "https://assets10.lottiefiles.com/packages/lf20_nux6g0kx.json"),
          ),
        ),
        const Center(
          child: Text(
            "Employee Deleted!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
