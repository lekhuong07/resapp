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

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie']!;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      header['cookie'] =  (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<void> signup(String email, String password, String confirmed) async {
    final url =  "http://10.0.2.2:5000/register";
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
    updateCookie(response);
    final responseData = json.decode(response.body);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    print(responseData);
    return responseData;
  }

  Future<void> login(String email, String password) async {
    final url =  "http://10.0.2.2:5000/login";
    final response = await Requests.post(
      "http://10.0.2.2:5000/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
          'email': email,
          'password': password,
        },
        bodyEncoding: RequestBodyEncoding.FormURLEncoded
    );
    response.raiseForStatus();
    dynamic json = response.json();
    print(json);
    final responseData =  response.json();
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    else if(responseData['success'] == true) {
      header = response.headers;
      print(header);
    }
    _token = responseData['email'];
    notifyListeners();
    return (responseData);
  }

  Future<void> logout() async {
    final url =  "http://10.0.2.2:5000/logout";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    updateCookie(response);
    final responseData = json.decode(response.body);
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    _token = '';
    notifyListeners();
    return (responseData);
  }

}