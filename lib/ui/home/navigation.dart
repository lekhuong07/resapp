import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/auth_provider.dart';
import 'package:resapp/ui/home/tab_navigator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}): super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<HomePage> {
  String _currentPage = "ProfilePage";
  List<String> pageKeys = ["ProfilePage", "PositionPage", "ViewPage", "SettingsPage"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "ProfilePage": GlobalKey<NavigatorState>(),
    "PositionPage": GlobalKey<NavigatorState>(),
    "ViewPage": GlobalKey<NavigatorState>(),
    "SettingsPage": GlobalKey<NavigatorState>(),
  };

  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "ProfilePage") {
            _selectTab("ProfilePage", 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
            children:<Widget>[
              _buildOffstageNavigator("ProfilePage"),
              _buildOffstageNavigator("PositionPage"),
              _buildOffstageNavigator("ViewPage"),
              _buildOffstageNavigator("SettingsPage"),
            ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              backgroundColor: const Color(0xFF424242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_outlined),
              label: 'Positions',
              backgroundColor: const Color(0xFF424242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: 'View',
              backgroundColor: const Color(0xFF424242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest_outlined),
              label: 'Settings',
              backgroundColor: const Color(0xFF424242),
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}