import 'package:flutter/material.dart';
import '../constants.dart' as Constants;
import 'login_screen.dart' as LoginScreen;
import 'signup_screen.dart' as SignupScreen;

final _navigatorKey = GlobalKey<NavigatorState>();

/*void _LogInNavigate() {
  _navigatorKey.currentState!.pushNamed(
    '/login',
  );
}

void _SignUpNavigate() {
  _navigatorKey.currentState!.pushNamed(
    '/signup',
  );
}

void _ForgotPassword() {
  _navigatorKey.currentState!.pushNamed(
    '/forgot_password',
  );
}

void _CheckEmail() {
  _navigatorKey.currentState!.pushNamed(
    '/check_email',
  );
}*/

class AuthPage extends StatefulWidget{
  AuthPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                  "Resapp",
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
                ElevatedButton(
                    onPressed: () { Navigator.pushNamed(context, '/login'); },
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
                    onPressed: () { Navigator.pushNamed(context, '/signup'); },
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
          )
        )
    );
  }
}
