import 'package:flutter/material.dart';
import 'ui/authenticate/authenticate_screen.dart' as AuthScreen;
import 'ui/authenticate/login_screen.dart' as LoginScreen;
import 'ui/authenticate/signup_screen.dart' as SignupScreen;
import 'ui/profile/profile_screen.dart' as ProfileScreen;
import 'ui/home_screen.dart' as HomeScreen;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => AuthScreen.AuthPage(title: "AuthPage"),
          '/login': (context) => LoginScreen.LoginPage(title: "LoginPage"),
          '/signup': (context) => SignupScreen.SignupPage(title: "SignupPage"),
          '/profile': (context) => ProfileScreen.ProfilePage(title: "ProfilePage"),
          '/home': (context) => HomeScreen.HomePage(),
        },
    );
  }
}

