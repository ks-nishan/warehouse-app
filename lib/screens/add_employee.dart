import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPhoneValid = true;
  bool isGenderValid = true;
  bool isAddressValid = true;
  bool isPositionValid = true;
  bool isSalaryValid = true;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee email";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee phone number";
    }
    if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee gender";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee address";
    }
    return null;
  }

  String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee position";
    }
    return null;
  }

  String? validateSalary(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter employee salary";
    }
    if (!RegExp(r"^\d+$").hasMatch(value)) {
      return "Please enter a valid salary amount";
    }
    return null;
  }

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
                controller: nameController,
                validator: validateName),
            Text(
              validateName(nameController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Email",
                controller: emailController,
                validator: validateEmail),
            Text(
              validateName(emailController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Mobile",
                textInputType: TextInputType.number,
                controller: phoneController,
                validator: validatePhone),
            Text(
              validateName(phoneController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Gender",
                controller: genderController,
                validator: validateGender),
            Text(
              validateName(genderController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Address",
                controller: addressController,
                validator: validateAddress),
            Text(
              validateName(addressController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Position",
                controller: positionController,
                validator: validatePosition),
            Text(
              validateName(positionController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
            getMyField(
                hintText: "Employee Salary",
                textInputType: TextInputType.number,
                controller: salaryController,
                validator: validateSalary),
            Text(
              validateName(salaryController.text) ?? '',
              style: TextStyle(color: Colors.red),
            ),
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
                          gender: (genderController.text),
                          address: (addressController.text),
                          position: (positionController.text),
                          salary: int.parse(salaryController.text));
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Success!!!",
                          desc: "Employee added to the database!",
                          btnOkOnPress: () {
                            addEmployeeAndNavigateToHome(employee, context);
                          }).show();
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

  Widget getMyField({
    required String hintText,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    String? errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          labelText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          errorText: errorText,
        ),
        validator: validator,
      ),
    );
  }

  void addEmployeeAndNavigateToHome(Employee employee, BuildContext context) {
    final studentRef = FirebaseFirestore.instance.collection('demo').doc();
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
