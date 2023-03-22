import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:warehouse_app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/screens/add_employee.dart';
import 'package:warehouse_app/screens/deleteSplash.dart';
import 'package:warehouse_app/screens/update_employee.dart';
//branch check

class EmployeeList extends StatelessWidget {
  final CollectionReference _referance =
      FirebaseFirestore.instance.collection('demo');

  List<Employee> employees = [
    // Employee(
    //     id: "2662161",
    //     name: "Mathy",
    //     email: "mathy@gmail.com",
    //     phone: 8566,
    //     position: "Intern",
    //     salary: 30000),
    // Employee(
    //     id: "2662161",
    //     name: "Mathy",
    //     email: "mathy@gmail.com",
    //     phone: 8566,
    //     position: "Intern",
    //     salary: 70000),
    // Employee(
    //     id: "2662161",
    //     name: "Mathy",
    //     email: "mathy@gmail.com",
    //     phone: 8566,
    //     position: "Intern",
    //     salary: 60000)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Management"),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _referance.get(),
        builder: (context, snapshot) {
          Colors.yellow[200];
          //check for error
          if (snapshot.hasError) {
            return const Center(
              child: Text("Somthing went wrong."),
            );
          }
          //if data resived
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            //convert to list
            List<Employee> employees = documents
                .map((e) => Employee(
                    id: e['id'],
                    name: e['name'],
                    email: e['email'],
                    phone: e['phone'],
                    gender: e['gender'],
                    address: e['address'],
                    position: e['position'],
                    salary: e['salary']))
                .toList();
            return _getBody(employees);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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

  Widget _getBody(employees) {
    return employees.isEmpty
        ? const Center(
            child: Text(
              "No Employees \n Click + button to add new",
              textAlign: TextAlign.center,
            ),
          )
        : Container(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) => Card(
                color: employees[index].salary < 35000
                    ? Colors.red.shade200
                    : employees[index].salary < 65000
                        ? Colors.blue.shade200
                        : Colors.green.shade200,
                child: ListTile(
                  title: Text(employees[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone: ${employees[index].phone}"),
                      Text("Email: ${employees[index].email}"),
                      Text("Gender: ${employees[index].gender}"),
                      Text("Address: ${employees[index].address}"),
                      Text("Position: ${employees[index].position}"),
                      Text("Salary: ${employees[index].salary}"),
                    ],
                  ),
                  leading: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey,
                      // child: Text('${employees[index].email}'),
                      child: Image.asset("assets/icons/manager.png")),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.yellow.withOpacity(1),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateEmployee(
                                          employee: employees[index])));
                            },
                          ),
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
                                    builder: (context) => DeleteSplash()));
                            //popup message
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
