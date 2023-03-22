import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/screens/app_starter.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/employee_list.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Management',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: AppStarter(),
    );
  }
}
