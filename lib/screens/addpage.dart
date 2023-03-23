import 'package:warehouse_app/screens/authenticate/register.dart';
import 'package:warehouse_app/screens/dashboard.dart';
import 'package:warehouse_app/screens/listpage.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/screens/suphome.dart';
import 'package:warehouse_app/services/auth.dart';
import '../models/dropdownoption.dart';
import '../services/firebase_crud.dart';
import 'package:warehouse_app/screens/authenticate/login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> with SingleTickerProviderStateMixin {
  // late TabController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = TabController(length: 2, vsync: this);
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  final AuthService _auth = new AuthService();
  String? selectedIem = 'pro1';
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final product = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final nameField = TextFormField(
        controller: name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final emailField = TextFormField(
        controller: email,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final phoneField = TextFormField(
        controller: phone,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 10) {
            return 'Enter valid number';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Contact Number",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final addressField = TextFormField(
        controller: address,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Address",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    String? selectedProduct;
    final productField = DropdownButtonFormField<String>(
      value: selectedProduct,
      onChanged: (String? newValue) {
        setState(() {
          selectedProduct = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a product';
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        labelText: 'Product',
        hintText: 'Please select a product',
      ),
      items: <String>['Apple', 'Banana', 'Orange']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    // final productField = TextFormField(
    //     controller: product,
    //     autofocus: false,
    //     validator: (value) {
    //       if (value == null || value.trim().isEmpty) {
    //         return 'This field is required';
    //       }
    //     },
    //     decoration: InputDecoration(
    //         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Product",
    //         border:
    //             OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //To disable back feature set to false
          );
        },
        child: const Text(
          "View List Of Suppliers",
          style:
              TextStyle(color: Color.fromARGB(255, 172, 172, 6), fontSize: 22),
          textAlign: TextAlign.center,
        ));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromARGB(255, 59, 59, 91),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.addSupplier(
                name: name.text,
                email: email.text,
                phone: phone.text,
                address: address.text,
                product: product.text);
            if (response.code != 200) {
              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const suphome()));

              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: const Text(
          "Save",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 249, 249), fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('Add Supplier'),
      //   backgroundColor: Colors.yellow[700],
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(
      //         Icons.logout,
      //         color: Colors.white,
      //       ),
      //       onPressed: () async {
      //         await _auth.signOut();
      //       },
      //     )
      //   ],
      //   // bottom: TabBar(controller: controller, tabs: const [
      //   //   Tab(icon: Icon(Icons.home)),
      //   //   Tab(icon: Icon(Icons.list)),
      //   // ]),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(
          //   child: TabBarView(controller: controller, children: const [
          //     AddPage(),
          //     ListPage(),
          //   ]),
          // ),
          SizedBox(
            width: 250.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 40.0,
                  color: Color.fromARGB(255, 59, 59, 91),
                  fontWeight: FontWeight.bold),
              child:
                  AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
                TyperAnimatedText('Add Supplier',
                    speed: Duration(milliseconds: 100)),
                // TyperAnimatedText('to the', speed: Duration(milliseconds: 100)),
                // TyperAnimatedText('Warehouse management ',
                //     speed: Duration(milliseconds: 100)),
                // TyperAnimatedText('system', speed: Duration(milliseconds: 100)),
              ]),
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 35.0),
                  emailField,
                  const SizedBox(height: 35.0),
                  phoneField,
                  const SizedBox(height: 35.0),
                  addressField,
                  const SizedBox(height: 35.0),
                  productField,
                  const SizedBox(height: 35.0),
                  // viewListbutton,
                  // const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
