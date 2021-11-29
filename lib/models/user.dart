import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier{
  String imageURL;
  String fullname;
  String dob;
  String email;
  String password;
  String ps; // personal_statement
  List<Application> apply;

  User({
    required this.fullname,
    required this.dob,
    required this.email,
    this.ps = "",
    this.password = "",
    this.imageURL = "",
    this.apply = const <Application>[]
  });
}

class Application {
  int index;
  String id;
  String positionName;
  String companyName;
  String status;
  String dateTime;

  Application({
    required this.id,
    required this.index,
    required this.positionName,
    required this.companyName,
    required this.dateTime,
    required this.status
  });
}