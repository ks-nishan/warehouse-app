import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../screens/Inventory_dashboard.dart';
class InventorySplash extends StatefulWidget {
  const InventorySplash({super.key});

  @override
  State<InventorySplash> createState() => _InventorySplashState();
}

class _InventorySplashState extends State<InventorySplash> {
  @override
  void initState() {
   super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    InventroyDashBoard()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
               Color.fromRGBO(9, 9, 9, 1),
              Color.fromRGBO(9, 9, 9, 1),
            ],
           )
         ),
         child:Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/s3.png',
                height: 300.0,
                width:300.0
                ),
                Text(
              "Inventory System Loading.....",
              textAlign: TextAlign.center,
              style:TextStyle(color:Color.fromARGB(255, 250, 234, 3),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              ),
              

            ),
            ],
          ),
            
            CircularProgressIndicator(),

         ]),
      ),

    );
  }
}