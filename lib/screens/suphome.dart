import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/screens/addpage.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/listpage.dart';
import 'package:warehouse_app/services/auth.dart';

// ignore: camel_case_types
class suphome extends StatefulWidget {
  const suphome({super.key});

  @override
  State<suphome> createState() => _suphomeState();
}

// ignore: camel_case_types
class _suphomeState extends State<suphome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _auth = new AuthService();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Management'),
        backgroundColor: Colors.yellow[700],
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.add_box)),
            Tab(icon: Icon(Icons.home)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ListPage(),
          AddPage(),
          Dashboard(),
        ],
      ),
    );
  }
}
