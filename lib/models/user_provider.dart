import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:requests/requests.dart';
import 'package:resapp/models/user.dart';

class ProviderUser with ChangeNotifier{
  User _userProfile;
  ProviderUser(this._userProfile);
  //User(
  //fullname: "",  dob: "",  email: '', ps: "",
  //apply: <Application> [
  //Application(id: 0, positionName: "SWE", companyName: "Google", dateTime: DateTime.now(), status: "Initialized"),
  //Application(id: 1, positionName: "SWE", companyName: "Facebook", dateTime: DateTime.now(), status: "Interviewing"),
  //Application(id: 2, positionName: "DS", companyName: "Apple", dateTime: DateTime.now(), status: "Declined"),
  //Application(id: 3, positionName: "DE", companyName: "Samsung", dateTime: DateTime.now(), status: "Accepted"),
  //],
  //);

  Application findById(int id){
    return _userProfile.apply.firstWhere((ap) => ap.index == id);
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

  Future<void> fetchAndSetUser() async {
    /*final url =  "https://kl-resume-app.herokuapp.com/profile/get";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    updateCookie(response);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    print(responseData);*/
    var response = await Requests.get(
      "https://kl-resume-app.herokuapp.com/profile/get",
    );
    response.raiseForStatus();
    dynamic responseData = response.json();
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    final List<Application> _application = [];
    for(int i = 0; i < responseData['message']['application'].length; i++){
      Map<String, dynamic> curr = responseData['message']['application'][i];
      _application.add(
          Application(
              index: i,
              id: curr['_id'],
              positionName: curr['details'][0],
              companyName: curr['details'][1],
              dateTime: curr['details'][2],
              status: curr['details'][3]
          )
      );
    }
    _userProfile = User(
        fullname: responseData['message']['name'],
        dob: responseData['message']['dob'],
        email: responseData['message']['email'],
        ps: responseData['message']['ps'],
        apply: _application
    );
    notifyListeners();
  }

  Future<void> updateProfile(Map<String, String> _editData) async {
    var response = await Requests.put(
        "https://kl-resume-app.herokuapp.com/profile/edit",
        json: {
          "name": _editData['name'],
          "dob": _editData['dob'],
          "statement": _editData['ps']
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> editPassword(Map<String, String> _editData) async {
    var response = await Requests.put(
        "https://kl-resume-app.herokuapp.com/password/edit",
        json: {
          "email": _editData['email'],
          "new_password": _editData['newPassword'],
          "confirmed_new_password": _editData['confirmed']
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }


  Future<void> updateApplication(String decision, String _id) async {
    var response = await Requests.put(
        "https://kl-resume-app.herokuapp.com/application/next_step/" + _id,
        json: {
          'status': decision,
        }
    );
    print(decision);
    print(_id);
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> addApplication(String company, String position) async {
    var response = await Requests.post(
        "https://kl-resume-app.herokuapp.com/application/add",
        json: {
          'company': company,
          'position': position
        }
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }

  Future<void> deleteApplication(String _id) async {
    var response = await Requests.delete(
        "https://kl-resume-app.herokuapp.com/application/delete/" + _id,
    );
    response.raiseForStatus();
    dynamic responseData = response.json();

    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    notifyListeners();
    return responseData;
  }
}