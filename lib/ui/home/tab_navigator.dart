import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/user.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/authenticate/authenticate_screen.dart';
import 'package:resapp/ui/authenticate/login_screen.dart';
import 'package:resapp/ui/position_list/position_screen.dart';
import 'package:resapp/ui/profile/profile_screen.dart';
import 'package:resapp/ui/settings/settings_screen.dart';
import 'package:resapp/ui/tips/tips_screen.dart';
import 'package:resapp/ui/view/splitted_view_screen.dart';
import 'package:resapp/ui/view/view_screen.dart';

import 'navigation.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProviderUser>(context);

    Widget child ;
    switch (tabItem){
      case "ProfilePage":
        child = ProfilePage(userProvider);
        break;
      case "PositionPage":
        child = PositionPage(positions: []);
        break;
      case "ViewPage":
        child = ViewPage(positions: []);
        break;
      case "TipsPage":
        child = TipsPage(title: 'TipsPage');
        break;
      case "SettingsPage":
        child = SettingsPage(userProvider);
        break;
      default:
        child = ProfilePage(userProvider);
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}