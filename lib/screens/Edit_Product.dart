import '../screens/product_list.dart';
import '../screens/Edit_Product.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../service/Inventory_Service.dart';

class EditPage extends StatefulWidget {
final Product? product;
 EditPage({this.product});

  @override
  State<StatefulWidget> createState() {
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _productId = TextEditingController();
  final _productName = TextEditingController();
  final _stock = TextEditingController();
  final _uPrice = TextEditingController();
  final _weight = TextEditingController();
  final _description = TextEditingController();
  final _type = TextEditingController();

  final _docid = TextEditingController();

   
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
  void initState() {

    _productId.value = TextEditingValue(text: widget.product!.productId.toString());
   _description.value = TextEditingValue(text: widget.product!.description.toString());
    _type.value = TextEditingValue(text: widget.product!.type.toString());
    _uPrice.value = TextEditingValue(text: widget.product!.uPrice.toString());
    _weight.value = TextEditingValue(text: widget.product!.weight.toString());
    _stock.value = TextEditingValue(text: widget.product!.stock.toString());
    _productName.value=TextEditingValue(text:widget.product!.productName.toString());
    
  }

  @override
  Widget build(BuildContext context) {


   
    final DocIDField = TextField(
        controller: _productId,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Product Id",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

  final nameField = TextFormField(
        controller:_productName,
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

    final descriptionField = TextFormField(
        controller: _description,  readOnly: true,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Description",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final typeField = TextFormField(
        controller:_type,   
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Type",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

              
  final weightField = TextFormField(
        controller: _weight,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Weight",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
                
  final stockField = TextFormField(
        controller: _stock,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "In Stock",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
               
  final upriceField = TextFormField(
        controller: _uPrice,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Unite Price",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
             
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
        child: const Text('View List of Products'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updateProduct(
               productId:_productId.text,
               description: _description.text,
                type: _type.text,
                docId: _docid.text,
                uPrice: _uPrice.text,
                weight: _weight.text,
                productName: _productName.text,
                stock: _stock.text);
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
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Products '),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:SingleChildScrollView( child:Column(
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
                  const SizedBox(height: 25.0),
                  nameField,
                  const SizedBox(height: 25.0),
                typeField,
                  const SizedBox(height: 25.0),
                weightField,
                const SizedBox(height: 25.0),
                upriceField,
                const SizedBox(height: 25.0),
                stockField,
                const SizedBox(height: 25.0),
                descriptionField,
                const SizedBox(height: 35.0),
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
      )
    );
  }
}