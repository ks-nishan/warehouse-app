import 'package:warehouse_app/page/listpurchasePage.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/page/listpurchasePage.dart';

import '../models/purchase.dart';
import '../service/crudpurchase.dart';

class EditPage extends StatefulWidget {
  final Purchase? purchase;
  EditPage({this.purchase});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _PlistID = TextEditingController();
  final _code = TextEditingController();
  final _Pname = TextEditingController();
  final _Pdate = TextEditingController();
  final _Qty = TextEditingController();
  final _unit = TextEditingController();
  final _Sname = TextEditingController();
  final _Ddate = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _docid.value = TextEditingValue(text: widget.purchase!.id.toString());
    _PlistID.value =
        TextEditingValue(text: widget.purchase!.PlistID.toString());
    _code.value = TextEditingValue(text: widget.purchase!.code.toString());
    _Pname.value = TextEditingValue(text: widget.purchase!.Pname.toString());
    _Pdate.value = TextEditingValue(text: widget.purchase!.Pdate.toString());
    _Qty.value = TextEditingValue(text: widget.purchase!.Qty.toString());
    _unit.value = TextEditingValue(text: widget.purchase!.unit.toString());
    _Sname.value = TextEditingValue(text: widget.purchase!.Sname.toString());
    _Ddate.value = TextEditingValue(text: widget.purchase!.Ddate.toString());
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    Colors.yellow[700];
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Title",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final listField = TextFormField(
        controller: _PlistID,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Purchase List ID",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final codeField = TextFormField(
        controller: _code,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Item code",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final PnameField = TextFormField(
        controller: _Pname,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Product Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final QtyField = TextFormField(
        controller: _Qty,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Quntity",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final UnitField = TextFormField(
        controller: _unit,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Unit of messure",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final SnameField = TextFormField(
        controller: _Sname,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Suppiler Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final PdateField = TextFormField(
        controller: _Pdate,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Spurchase date",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final deliveryField = TextFormField(
        controller: _Ddate,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Delivery Date",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updatePurchase(
                PlistID: _PlistID.text,
                code: _code.text,
                Pname: _Pname.text,
                Pdate: _Pdate.text,
                Qty: _Qty.text,
                unit: _unit.text,
                Sname: _Sname.text,
                Ddate: _Ddate.text,
                docId: _docid.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
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
        child: Text(
          "Update",
          style: TextStyle(color: Color.fromARGB(255, 32, 27, 13)),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final viewListbutton = TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ListPage(),
          ),
          (route) => false,
        );
      },
      child: Text(
        "View List of Purchase",
        style: TextStyle(color: Color.fromARGB(255, 20, 17, 9)),
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Purchase'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DocIDField,
                  const SizedBox(height: 18.0),
                  listField,
                  const SizedBox(height: 18.0),
                  codeField,
                  const SizedBox(height: 18.0),
                  PnameField,
                  const SizedBox(height: 18.0),
                  PdateField,
                  const SizedBox(height: 18.0),
                  QtyField,
                  const SizedBox(height: 18.0),
                  UnitField,
                  const SizedBox(height: 18.0),
                  deliveryField,
                  const SizedBox(height: 18.0),
                  SnameField,
                  const SizedBox(height: 18.0),
                  SaveButon,
                  const SizedBox(height: 45.0),
                  viewListbutton,
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
