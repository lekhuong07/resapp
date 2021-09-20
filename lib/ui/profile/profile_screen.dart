import 'package:flutter/material.dart';
import '../constants.dart' as Constants;
import '../home_screen.dart';

class ProfilePage extends StatefulWidget{
  ProfilePage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Profile',
      style: optionStyle,
    ),
    Text(
      'Index 1: View',
      style: optionStyle,
    ),
    Text(
      'Index 2: Tips',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> entries = <String>['Job1', 'Job2', 'Job3'];
  final List<int> index = [1, 2, 3];

  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
        body: Center(
            child: Column(
              children: <Widget> [
                Expanded (
                  flex: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Expanded(
                        flex: 30,
                        child: Container(
                          child:  Image.asset(
                            "assets/images/frame10.png",
                            height: Constants.imageHeight(context),
                            width: Constants.imageWidth(context),
                          ),
                        )
                      ),
                      Expanded(
                        flex:70,
                        child: Column (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            SizedBox(height: Constants.screenTab(context)),
                            Text("Your Name Here",
                              style: TextStyle(
                                color: Constants.appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.fontSizeNormal(context),
                              ),
                            ),
                          Container(
                            child:
                              Text("This should be a very very long statement about yourself, testing to see how long it gets.",
                              overflow: TextOverflow.visible,
                              style: new TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: Constants.fontSizeSmall(context),
                              ),
                            ),
                          ),
                          ],
                        )
                      )
                    ],
                  )
                ),
                Expanded(
                  flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          index.add(index[index.length - 1] + 1);
                          entries.add('Job' + index[index.length - 1].toString());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Constants.appColor,
                          fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                        ),
                        child: Icon(Icons.post_add)
                      )
                      ]
                    ),
                ),
                Expanded (
                    flex: 70,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: Constants.screenTab(context)/2, right: Constants.screenTab(context)/2),
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                            onPressed: () {  },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              fixedSize: Size(Constants.buttonWidth(context), Constants.buttonHeight(context)),
                            ),
                          child: Center(
                              child: Text('Entry ${entries[index]}',
                                overflow: TextOverflow.visible,
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: Constants.fontSizeSmall(context),
                                ),
                              )
                          )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                ),
              ]
            )
        ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
