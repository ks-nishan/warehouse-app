import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/screens/add_employee.dart';
import 'package:warehouse_app/screens/update_employee.dart';
//branch check

class EmployeeList extends StatelessWidget {
  final CollectionReference _referance =
      FirebaseFirestore.instance.collection('students');

  List<Employee> employees = [
    Employee(
        id: "2662161",
        name: "Mathy",
        email: "mathy@gmail.com",
        phone: 8566,
        position: "Intern",
        salary: 30000),
    Employee(
        id: "2662161",
        name: "Mathy",
        email: "mathy@gmail.com",
        phone: 8566,
        position: "Intern",
        salary: 70000),
    Employee(
        id: "2662161",
        name: "Mathy",
        email: "mathy@gmail.com",
        phone: 8566,
        position: "Intern",
        salary: 60000)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        centerTitle: true,
      ),
      body: employees.isEmpty
          ? const Center(
              child: Text(
                "No Employees \n Click + button to add new",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) => Card(
                color: employees[index].salary < 35000
                    ? Colors.red.shade200
                    : employees[index].salary < 65000
                        ? Colors.yellow.shade200
                        : Colors.green.shade200,
                child: ListTile(
                  title: Text(employees[index].name),
                  subtitle: Text("Mobile No : ${employees[index].phone}"),
                  leading: CircleAvatar(
                    radius: 25,
                    child: Text('${employees[index].email}'),
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.edit,
                            color: Colors.black.withOpacity(0.75),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UpdateEmployee(
                            //             employee: employees[index])));
                          },
                        ),
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.withOpacity(0.75),
                          ),
                          onTap: () {
                            //
                            _referance.doc(employees[index].id).delete();
                            //re load the page
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeeList()));
                            //popup message
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEmployee()));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
