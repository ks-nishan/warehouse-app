import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warehouse_app/screens/add_employee.dart';
import 'package:warehouse_app/screens/employee_list.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
      title: "Inventory",
      subtitle: "Stock Management",
      navigate: EmployeeList(),
      img: "assets/icons/inventory.png");

  Items item2 = Items(
    title: "Purchase",
    subtitle: "Materials",
    navigate: EmployeeList(),
    img: "assets/icons/procurement.png",
  );
  Items item3 = Items(
    title: "Employees",
    subtitle: "Factory Workers",
    navigate: EmployeeList(),
    img: "assets/icons/employee.png",
  );
  Items item4 = Items(
    title: "Supplier",
    subtitle: "Supply chain",
    navigate: EmployeeList(),
    img: "assets/icons/supplier.png",
  );
  Items item5 = Items(
    title: "Help",
    subtitle: "Customer Support",
    navigate: AddEmployee(),
    img: "assets/icons/customer-service.png",
  );
  Items item6 = Items(
    title: "Log Out",
    subtitle: "",
    navigate: AddEmployee(),
    img: "assets/icons/check-out.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> itemList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: itemList.map((data) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => data.navigate),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "- - -",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  Widget navigate;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.navigate,
      required this.img});
}
