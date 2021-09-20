import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class SignupPage extends StatefulWidget{
  SignupPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  String email = '';
  String password = '';
  String confirm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SizedBox(height: Constants.screenTab(context)*3),
                Text("Resapp",
                  style: TextStyle(
                    color: Constants.appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.fontSizeBig(context),
                  ),
                ),
                Image.asset(
                  "assets/images/frame10.png",
                  height: Constants.imageHeight(context),
                  width: Constants.imageWidth(context),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                    children: <Widget> [
                      ElevatedButton(
                          onPressed: () { Navigator.pushNamed(context, '/login'); },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.appDisabledColor,
                            fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {  },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.appColor,
                            fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                          )
                      ),
                    ]
                ),
                SizedBox(height: Constants.screenTab(context)),
                Container(
                  margin: EdgeInsets.only(left: Constants.screenTab(context), right: Constants.screenTab(context)),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    onChanged: (text) {
                      setState(() { email = text; });
                    },
                  )
                ),
                SizedBox(height: Constants.screenTab(context)),
                Container(
                    margin: EdgeInsets.only(left: Constants.screenTab(context), right: Constants.screenTab(context)),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                    ),
                      onChanged: (text) {
                        setState(() {  password = text; });
                      },
                    )
                ),
                SizedBox(height: Constants.screenTab(context)),
                Container(
                    margin: EdgeInsets.only(left: Constants.screenTab(context), right: Constants.screenTab(context)),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm password',
                      ),
                      onChanged: (text) {
                        setState(() { confirm = text; });
                      },
                    ),
                ),
                SizedBox(height: Constants.screenTab(context)),
                ElevatedButton(
                    onPressed: () { Navigator.pushNamed(context, '/home'); },
                    style: ElevatedButton.styleFrom(
                      primary: Constants.appColor,
                      fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                    ),
                    child: Text(
                      "RestIt !",
                      style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                    )
                ),
              ]
          ),
        )
    );
  }
}