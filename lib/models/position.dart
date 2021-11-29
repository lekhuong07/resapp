import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Position with ChangeNotifier{
  int index;
  String title;
  String dataId;
  List<Section> section;
  //List<bool> isShown;

  Position({
    required this.index,
    required this.title,
    required this.section,
    required this.dataId
  });
}

class Section with ChangeNotifier {
  int index;
  String name;
  String dataId;
  List<Experience> experience;
  List<Skill> skill;
  bool isChosen;

  Section({
    required this.index,
    required this.name,
    required this.dataId,
    List<Experience> experience =  const <Experience>[],
    List<Skill> skill = const <Skill>[],
  }) : experience = experience, skill = skill, this.isChosen = false;

  void toggleShowHide(bool flag) {
    isChosen = flag;
    notifyListeners();
  }

}

class Experience with ChangeNotifier {
  int index;
  String dataId;
  String title;
  String place;
  String cityState;
  String country;
  String startDate;
  String endDate;
  bool isChosen;
  List<String> description;

  Experience({
    required this.index,
    required this.title,
    required this.place,
    required this.cityState,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.dataId,
    this.isChosen = false,
  });
}

class  Skill with ChangeNotifier {
  int index;
  String dataId;
  String title;
  bool isChosen;
  List<String> description;

  Skill({
    required this.index,
    required this.dataId,
    required this.title,
    required this.description,
    this.isChosen = false,
  });
}