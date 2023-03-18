// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.position,
    required this.salary,
  });

  String? id;
  final String name;
  final String email;
  final int phone;
  final String position;
  final int salary;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        position: json["position"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "position": position,
        "salary": salary,
      };
}
