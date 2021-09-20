import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class LoginPage extends StatefulWidget{
  LoginPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                      onPressed: () {  },
                      style: ElevatedButton.styleFrom(
                        primary: Constants.appColor,
                        fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {  Navigator.pushNamed(context, '/signup');  },
                      style: ElevatedButton.styleFrom(
                        primary: Constants.appDisabledColor,
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (text) {
                    setState(() { password = text; });
                  },
                )
            ),
            SizedBox(height: Constants.screenTab(context)),
            ElevatedButton(
                onPressed: () { Navigator.pushNamed(context, '/profile'); },
                style: ElevatedButton.styleFrom(
                  primary: Constants.appColor,
                  fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                ),
                child: Text(
                  "RestIt !",
                  style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                )
            ),
            SizedBox(height: Constants.screenTab(context)),
            TextButton(
                onPressed: () {  },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.black, fontSize: Constants.fontSizeSmall(context)),
                )
            ),
          ]
        ),
      )
     );
  }
}
