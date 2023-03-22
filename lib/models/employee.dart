// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.address,
    required this.position,
    required this.salary,
  });

  String? id;
  final String name;
  final String email;
  final int phone;
  final String gender;
  final String address;
  final String position;
  final int salary;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        address: json["address"],
        position: json["position"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "address": address,
        "position": position,
        "salary": salary,
      };
}
