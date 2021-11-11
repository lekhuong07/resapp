import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/auth_provider.dart';
import 'package:resapp/models/http_exception.dart';
import '../constants.dart' as Constants;

class LoginPage extends StatefulWidget{
  LoginPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  var _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit(_authData) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
      'email': ''
    };
    setState(() {
      _isLoading = true;
    });
    try {
      data = await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      ) as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
    _showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    if (data['success'] == true) {
      Navigator.pushNamed(context, '/navigation');
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            SizedBox(height: Constants.screenTab(context)),
            Image.asset(
              "assets/images/frame2.png",
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
                height: Constants.buttonHeight(context),
                margin: EdgeInsets.only(left: Constants.screenTab(context)*2, right: Constants.screenTab(context)*2),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (text) {
                    setState(() { _authData['email'] = text; });
                  },
                )
            ),
            SizedBox(height: Constants.screenTab(context)),
            Container(
                height: Constants.buttonHeight(context),
                margin: EdgeInsets.only(left: Constants.screenTab(context)*2, right: Constants.screenTab(context)*2),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (text) {
                    setState(() { _authData['password'] = text; });
                  },
                )
            ),
            SizedBox(height: Constants.screenTab(context)),
            ElevatedButton(
                onPressed: () { _submit(_authData); },
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
                onPressed: () {  Navigator.pushNamed(context, '/forgot_password');  },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.black, fontSize: Constants.fontSizeSmall(context)),
                )
            ),
          ]
        ),
      )
     ),
    );
  }
}
