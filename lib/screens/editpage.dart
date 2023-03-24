import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:warehouse_app/models/supplier.dart';
import 'package:warehouse_app/screens/listpage.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/screens/suphome.dart';
import 'package:warehouse_app/services/auth.dart';
import '../services/firebase_crud.dart';
import 'authenticate/login.dart';

class EditPage extends StatefulWidget {
  final Supplier? supplier;
  EditPage({super.key, this.supplier});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final AuthService _auth = new AuthService();
  final prodctList = <String>['Paint', 'Wood', 'Glass', 'Furniture'];
  String selectedProduct = "Paint";
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final product = TextEditingController();
  final docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    docid.value = TextEditingValue(text: widget.supplier!.uid.toString());
    name.value = TextEditingValue(text: widget.supplier!.name.toString());
    email.value = TextEditingValue(text: widget.supplier!.email.toString());
    phone.value = TextEditingValue(text: widget.supplier!.phone.toString());
    address.value = TextEditingValue(text: widget.supplier!.address.toString());
    product.value = TextEditingValue(text: widget.supplier!.product.toString());
  }

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
          if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
            return 'Enter a valid 10-digit number';
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
    final productField = DropdownButtonFormField<String>(
      value: selectedProduct,
      onChanged: (String? newValue) {
        setState(() {
          selectedProduct = newValue!;
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
      items: prodctList.map((String value) {
        return DropdownMenuItem(
          child: Text(value),
          value: value,
        );
      }).toList(),
    );
    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text(
          "View List Of Suppliers",
          style:
              TextStyle(color: Color.fromARGB(255, 172, 172, 6), fontSize: 22),
          textAlign: TextAlign.center,
        ));

    // ignore: non_constant_identifier_names
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromARGB(255, 59, 59, 91),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Widget result;
            var response = await FirebaseCrud.updateSupplier(
              name: name.text,
              email: email.text,
              phone: phone.text,
              address: address.text,
              product: selectedProduct,
              docId: docid.text,
            );

            if (response.code != 200) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => EditPage()));

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
                  MaterialPageRoute(builder: (context) => suphome()));

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
          "Update",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 249, 249), fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Update Supplier'),
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
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30, right: 16, left: 16),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                width: 300.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 40.0,
                      color: Color.fromARGB(255, 59, 59, 91),
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        TyperAnimatedText('Update Supplier',
                            speed: Duration(milliseconds: 100)),
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
          )),
        ));
  }
}
