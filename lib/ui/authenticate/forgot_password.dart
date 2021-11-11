import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class LoginPage extends StatefulWidget{
  LoginPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(

        )
    );
  }
}
