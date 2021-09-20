import 'package:flutter/material.dart';
import 'constants.dart' as Constants;

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State {
  int _currentIndex = 0;
  final List _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: const Color(0xFF424242),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'View',
            backgroundColor: const Color(0xFF424242),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_rounded),
            label: 'Tips',
            backgroundColor: const Color(0xFF424242),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_suggest_outlined),
            label: 'Settings',
            backgroundColor: const Color(0xFF424242),
          ),
        ],
      ),
    );
  }
}
