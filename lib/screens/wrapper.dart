import 'package:provider/provider.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/listpage.dart';
import '../screens/addpage.dart';
import 'package:flutter/material.dart';

import '../models/FirebaseUser.dart';
import 'authenticate/handler.dart';
import 'authenticate/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return const Dashboard();
    }
  }
}
