import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/models/employee.dart';
import 'package:warehouse_app/screens/employee_list.dart';
import 'package:warehouse_app/screens/updateSplash.dart';

class UpdateEmployee extends StatelessWidget {
  final Employee employee;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController positionController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  UpdateEmployee({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    nameController.text = employee.name;
    emailController.text = employee.email;
    phoneController.text = '${employee.phone}';
    genderController.text = employee.gender;
    addressController.text = employee.address;
    positionController.text = employee.position;
    salaryController.text = '${employee.salary}';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Employee"),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Edit Empl0yee",
              style: TextStyle(
                  color: Color(0xff453658),
                  fontWeight: FontWeight.w600,
                  fontSize: 36.0),
            ),
            getMyField(
                focusNode: focusNode,
                hintText: "Employee Name",
                controller: nameController),
            getMyField(hintText: "Email", controller: emailController),
            getMyField(
                hintText: "Mobile",
                textInputType: TextInputType.number,
                controller: phoneController),
            getMyField(hintText: "Gender", controller: genderController),
            getMyField(hintText: "Address", controller: addressController),
            getMyField(hintText: "Position", controller: positionController),
            getMyField(
                hintText: "Basic Salary",
                textInputType: TextInputType.number,
                controller: salaryController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10, // set the elevation to 10
                      backgroundColor: Colors.yellow[700],
                    ),
                    onPressed: () {
                      //
                      Employee updatedEmployee = Employee(
                          id: employee.id,
                          name: nameController.text,
                          email: emailController.text,
                          phone: int.parse(phoneController.text),
                          gender: genderController.text,
                          address: addressController.text,
                          position: positionController.text,
                          salary: int.parse(salaryController.text));

                      final collectionReferance =
                          FirebaseFirestore.instance.collection('demo');
                      collectionReferance
                          .doc(updatedEmployee.id)
                          .update(updatedEmployee.toJson())
                          .whenComplete(() {
                        print('Employee updated');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateSplash()));
                      });
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // set the elevation to 10
                    backgroundColor: Color(0xff453658),
                  ),
                  onPressed: () {
                    nameController.text = "";
                    emailController.text = "";
                    phoneController.text = "";
                    genderController.text = "";
                    addressController.text = "";
                    positionController.text = "";
                    salaryController.text = "";
                  },
                  child: const Text(
                    "Cancel",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: "Enter $hintText",
            labelText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
