import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:resapp/models/user.dart';
import 'package:http/http.dart' as http;

class ProviderUser with ChangeNotifier{
  final Map<String, String> header;
  var _userProfile;
  ProviderUser(this.header, this._userProfile);
  //User(
  //fullname: "",  dob: "",  email: '', ps: "",
  //apply: <Application> [
  //Application(id: 0, positionName: "SWE", companyName: "Google", dateTime: DateTime.now(), status: "Initialized"),
  //Application(id: 1, positionName: "SWE", companyName: "Facebook", dateTime: DateTime.now(), status: "Interviewing"),
  //Application(id: 2, positionName: "DS", companyName: "Apple", dateTime: DateTime.now(), status: "Declined"),
  //Application(id: 3, positionName: "DE", companyName: "Samsung", dateTime: DateTime.now(), status: "Accepted"),
  //],
  //);

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie']!;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      header['cookie'] =  (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<void> fetchAndSetUser() async {
    final url =  "http://10.0.2.2:5000/profile/get";
    print(header);
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    updateCookie(response);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    print(responseData);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    final List<Application> _application = [];
    for(int i = 0; i < responseData['application'].length; i++){
      Map<String, dynamic> curr = responseData['application'][i];
      _application.add(
        Application(
          id: curr['id'],
          positionName: curr['details'][0],
          companyName: curr['details'][1],
          dateTime: curr['details'][2],
          status: curr['details'][3]
        )
      );
    }

    _userProfile = User(
      fullname: responseData['name'],
      dob: responseData['dob'],
      email: responseData['dob'],
      apply:  _application
    );
    notifyListeners();
  }

  Application findById(int id){
    return _userProfile.apply.firstWhere((ap) => ap.id == id);
  }

  List<Application> getApplication()  {
    return _userProfile.apply;
  }

  Map<String, double> applicationMap() {
    Map result = { };
    List<Application> app = this._userProfile.apply;
    for(var i = 0; i < app.length; i++){
      String st = app[i].status;
      if (result.containsKey(st)){
        result[st] += 1.0;
      }
      else{
        result[st] = 1.0;
      }
    }
    return Map<String, double>.from(result);
  }


  int get itemCount {
    return _userProfile.apply.length;
  }

  User get userProfile {
    return _userProfile;
  }

  void addApplication(String positionName, String companyName) {
    _userProfile.apply.insert(
      _userProfile.apply.length,
      Application(
        id: _userProfile.apply.length+1,
        positionName: positionName,
        companyName: companyName,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

}