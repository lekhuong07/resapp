import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Position with ChangeNotifier{
  int id;
  String title;
  List<Section> section;
  //List<bool> isShown;

  Position({
    required this.id,
    required this.title,
    required this.section,
  });
}

class Section with ChangeNotifier {
  String name;
  List<Experience> experience;
  List<Skill> skill;
  bool isChosen;
  Section({
    required String name,
    List<Experience> experience =  const <Experience>[],
    List<Skill> skill = const <Skill>[]
  }) : name = name, experience = experience, skill = skill, this.isChosen = false;

  void toggleShowHide(bool flag) {
    isChosen = flag;
    notifyListeners();
  }

}

class Experience {
  String id;
  String title;
  String place;
  String city_state;
  String country;
  String start_month;
  String start_year;
  String end_month;
  String end_year;
  bool isChosen;
  List<String> description;

  Experience({
    required this.title,
    required this.place,
    required this.city_state,
    required this.country,
    required this.start_month,
    required this.start_year,
    required this.end_month,
    required this.end_year,
    required this.description,
    this.isChosen = false,
    this.id = ''
  });
}

class  Skill {
  String id;
  String title;
  bool isChosen;
  List<String> description;

  Skill({
    required this.title,
    required this.description,
    this.isChosen = false,
    this.id = ''
  });
}