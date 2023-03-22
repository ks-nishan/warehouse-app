// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_app/screens/addpage.dart';
import 'package:warehouse_app/screens/app_starter.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/employee_list.dart';
import 'services/auth.dart';
import 'models/FirebaseUser.dart';
import 'screens/wrapper.dart';
import 'package:warehouse_app/screens/n_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wareouse Management',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: Wrapper(),
      ),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Employee Management',
    //   theme: ThemeData(primarySwatch: Colors.indigo),
    //   home: AddPage(),
    // );
  }
}
