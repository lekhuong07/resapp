import 'dart:async';

import 'package:requests/requests.dart';

import 'http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token = '';
  Map<String, String> header = {};

  bool get isAuth {
    print(token);
    print(token != '');
    return token != '';
  }

  String get token {
    return _token;
  }

  Future<void> signup(String email, String password, String confirmed) async {
    /*final url =  "https://kl-resume-app.herokuapp.com/register";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'confirmed_password': confirmed
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    print(responseData);
    return responseData;*/
    var r = await Requests.post(
        "https://kl-resume-app.herokuapp.com/register",
        json: {
          'email': email,
          'password': password,
          'confirmed_password': confirmed
        },
    );
    r.raiseForStatus();
    dynamic rjson = r.json();
    if (rjson['success'] == false){
      throw HttpException(rjson['message']);
    }
    notifyListeners();
    return (rjson);
  }

  Future<void> login(String email, String password) async {/*
    final url =  "https://kl-resume-app.herokuapp.com/login";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    else if(responseData['success'] == true) {
      header = response.headers;
      print(header);
    }
    _token = responseData['email'];
    notifyListeners();
    return (responseData);*/
    var r = await Requests.post(
        "https://kl-resume-app.herokuapp.com/login",
        json: {
          'email': email,
          'password': password,
        }
    );
    r.raiseForStatus();
    dynamic rjson = r.json();
    if (rjson['success'] == false){
      throw HttpException(rjson['message']);
    }
    _token = rjson['email'];
    notifyListeners();
    return (rjson);
  }

  Future<void> logout() async {
    /*final url =  "https://kl-resume-app.herokuapp.com/logout";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final responseData = json.decode(response.body);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    _token = '';
    notifyListeners();
    return (responseData);*/
    var r = await Requests.post(
        "https://kl-resume-app.herokuapp.com/api_logout",
    );

    r.raiseForStatus();
    dynamic rjson = r.json();
    if (rjson['success'] == false){
      throw HttpException(rjson['message']);
    }
    _token = rjson['email'];
    notifyListeners();
    return (rjson);
  }

  Future<void> resetPassword(Map<String, String> _editData) async {
    var response = await Requests.post(
        "https://kl-resume-app.herokuapp.com/password/forgot",
        json: {
          "email": _editData['email']
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
}