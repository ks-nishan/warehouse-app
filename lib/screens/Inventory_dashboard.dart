import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/models/product.dart';
import 'package:warehouse_app/screens/add_product.dart';
import 'package:warehouse_app/screens/product_list.dart';
import 'package:warehouse_app/screens/qrScanner.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Inventory DashBoard"),
      backgroundColor: Colors.yellow[700],
      foregroundColor: Colors.black,),
      body: Container(
        child:Padding(padding: const EdgeInsets.all(10.0),child: GridView(children: [
        InkWell(
          onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_product()));
          },
          child: Container(height: 1,width: 1,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.yellow[700],border: Border.all(
                color: Colors.black,
                width: 2,
              ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.add,size:50,color:Colors.black,),
            Text("Add Product",style: TextStyle(color: Colors.black,fontSize: 30),)
          ]),),
        ),
        InkWell(
           onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>ListPage()));
          },
          child: Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.yellow[700],border: Border.all(
                color: Colors.black,
                width: 2,
              ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.file_copy,size:50,color:Colors. black,),
            Text("View Product",style: TextStyle(color: Colors.black,fontSize: 30),)
          ]),),
        ),
     
        InkWell(
           onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>QrScanner()));
          },
          child: Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.yellow[700],border: Border.all(
                color: Colors.black,
                width: 2,
              ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.scanner,size:50,color:Colors. black,),
            Text("QR Scanner",style: TextStyle(color: Colors.black,fontSize: 30),)
          ]),),
        ),
      ],
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 20,crossAxisSpacing: 20,  childAspectRatio: 1.0,),)),
     ), );
  }
}