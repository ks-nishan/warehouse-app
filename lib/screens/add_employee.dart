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
  String? _nameError;
  String? selectedGender;
  List<String> _genderOptions = ['Male', 'Female', 'Other'];

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
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Add New Emplyee",
              style: TextStyle(
                  color: Color(0xff453658),
                  fontWeight: FontWeight.w600,
                  fontSize: 36.0),
            ),
            getMyField(
              focusNode: focusNode,
              hintText: "Employee Name",
              controller: nameController,
              errorText: _nameError,
            ),
            getMyField(
              hintText: "Email",
              controller: emailController,
            ),
            getMyField(
              hintText: "Mobile",
              textInputType: TextInputType.number,
              controller: phoneController,
            ),
            getGender(
              hintText: 'Gender',
              items: ['Male', 'Female', 'Other'],
              controller: genderController,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
              initialValue: selectedGender,
            ),
            getMyField(
              hintText: "Address",
              controller: addressController,
            ),
            getMyField(
              hintText: "Position",
              controller: positionController,
            ),
            getMyField(
              hintText: "Salary",
              textInputType: TextInputType.number,
              controller: salaryController,
            ),
            SizedBox(
              height: 20,
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
                  child: const Text(
                    "Add",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // set the elevation to 10
                    backgroundColor: Colors.yellow[700],
                  ),
                ),
                ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // set the elevation to 10
                    backgroundColor: Color(0xff453658),
                  ),
                )
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
          errorText: errorText, // update errorText property
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText is required';
          }
          if (validator != null) {
            // update errorText property with the error message returned by validator
            return validator(value);
          }
          return null;
        },
      ),
    );
  }

  Widget getGender({
    required String hintText,
    required List<String> items,
    required TextEditingController controller,
    required ValueChanged<String?> onChanged,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<String>(
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        value: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Select $hintText",
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
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
