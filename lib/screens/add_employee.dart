import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/models/employee.dart';
import 'package:warehouse_app/screens/employee_list.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMyField(
                focusNode: focusNode,
                hintText: "Employee Name",
                controller: nameController),
            getMyField(hintText: "Employee Email", controller: emailController),
            getMyField(
                hintText: "Employee Mobile",
                textInputType: TextInputType.number,
                controller: phoneController),
            getMyField(
                hintText: "Employee Gender", controller: genderController),
            getMyField(
                hintText: "Employee Address", controller: addressController),
            getMyField(
                hintText: "Employee Position", controller: positionController),
            getMyField(
                hintText: "Employee Salary",
                textInputType: TextInputType.number,
                controller: salaryController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      Employee employee = Employee(
                          name: (nameController.text),
                          email: (emailController.text),
                          phone: int.parse(phoneController.text),
                          position: (positionController.text),
                          salary: int.parse(salaryController.text));
                      addEmployeeAndNavigateToHome(employee, context);
                    },
                    child: const Text("Add")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                    onPressed: () {
                      nameController.text = "";
                      emailController.text = "";
                      phoneController.text = "";
                      genderController.text = "";
                      addressController.text = "";
                      positionController.text = "";
                      salaryController.text = "";
                    },
                    child: const Text("Cancel"))
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

  void addEmployeeAndNavigateToHome(Employee employee, BuildContext context) {
    final studentRef = FirebaseFirestore.instance.collection('employees').doc();
    employee.id = studentRef.id;
    final data = employee.toJson();
    studentRef.set(data).whenComplete(() {
      //
      print("Inserted Successful");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeList(),
          ));
      //
    });
  }
}
