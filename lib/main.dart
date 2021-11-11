import 'package:flutter/material.dart';
import 'package:resapp/ui/home/navigation.dart';
import 'package:resapp/ui/position_list/position_editor.dart';
import 'package:resapp/ui/settings/settings_screen.dart';
import 'package:resapp/ui/view/listed_view_screen.dart';
import 'package:resapp/ui/view/splitted_view_screen.dart';
import 'models/auth_provider.dart';
import 'models/dummy_position.dart';
import 'models/position.dart';
import 'models/user.dart';
import 'models/user_provider.dart';
import 'ui/authenticate/authenticate_screen.dart';
import 'ui/authenticate/login_screen.dart';
import 'ui/authenticate/signup_screen.dart';
import 'ui/profile/profile_screen.dart';

import 'package:provider/provider.dart';
import 'models/position_provider.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Auth()
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderPositions(),
        ),
        ChangeNotifierProxyProvider<Auth, ProviderUser>(
          create: (_) => ProviderUser({"":""}, User(
            fullname: "",  dob: "",  email: '', ps: "",
            apply: <Application> [],
          )),
          update: (context, auth, previousUser) => ProviderUser(
              auth.header,
              previousUser == null ? [] : previousUser.userProfile,
          ),
        ),
      ],
      child: Consumer<Auth>(builder: (context, auth, _) =>
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ? HomePage() : AuthPage(title: 'AuthPage'),
          routes: {
            '/auth': (context) => AuthPage(title: 'AuthPage'),
            '/login': (context) => LoginPage(title: "LoginPage"),
            '/signup': (context) => SignupPage(title: "SignupPage"),
            '/forgot_password': (context) => SignupPage(title: "SignupPage"),
            '/position_edit': (context) => PositionEditor(),
            '/profile': (context) => ProfilePage(),
            '/navigation': (context) => HomePage(),
            '/settings': (context) => SettingsPage(title:'SettingsPage')
          },
      ), )
    );
  }
}

