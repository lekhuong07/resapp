import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier{
  String imageURL;
  String fullname;
  String dob;
  String email;
  String ps; // personal_statement
  List<Application> apply;

  User({
    required this.fullname,
    required this.dob,
    required this.email,
    this.ps = "",
    this.imageURL = "",
    this.apply = const <Application>[]
  });
}

class Application {
  int id;
  String positionName;
  String companyName;
  String status;
  final DateTime dateTime;

  Application({
    required this.id,
    required this.positionName,
    required this.companyName,
    required this.dateTime,
    this.status = "In progress"
  });
}