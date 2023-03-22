import 'package:flutter/material.dart';
import '../service/Inventory_Service.dart';
import '../screens/product_list.dart';
import '../models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AllProduct extends StatefulWidget {
  final Product? product;
 AllProduct({this.product});
 @override
  State<StatefulWidget> createState() {
    return _AllProduct();
  }
}

class _AllProduct extends State<AllProduct> {
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

    final descriptionField = TextFormField(
        controller: _description,
         readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Description",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final typeField = TextFormField(
        controller:_type,
         readOnly: true,
        autofocus: false,
        
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Type",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

              
  final weightField = TextFormField(
        controller: _weight,
         readOnly: true,
        autofocus: false,
       
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Weight",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
                
  final stockField = TextFormField(
        controller: _stock,
         readOnly: true,
        autofocus: false,
       
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "In Stock",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
               
  final upriceField = TextFormField(
        controller: _uPrice,
         readOnly: true,
        autofocus: false,
       
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
        child: const Text('Back')
        );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Product View '),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
            widget.product!.productName.toString(),
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
                  DocIDField,
                  const SizedBox(height: 25.0),
                  typeField,
                  const SizedBox(height: 25.0),
                  weightField,
                    const SizedBox(height: 25.0),
                  stockField,
                    const SizedBox(height: 25.0),
                    upriceField,
                     const SizedBox(height: 25.0),
                 descriptionField,
                   const SizedBox(height: 35.0),
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}