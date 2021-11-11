import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/auth_provider.dart';
import 'package:resapp/models/http_exception.dart';
import 'package:resapp/ui/authenticate/authenticate_screen.dart';
import '../constants.dart' as Constants;
import '../constants.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _editedProduct = {
    'title': '',
    'price': 0,
    'description': '',
    'imageUrl': '',
  };

  var _initValues = {
    'name': 'KL',
    'dob': '02/16/1997',
    'ps': 'FKU',
  };


  final List<String> entries = <String>['Change profile picture', 'Change contact information', 'Change password', 'Privacy Policy', 'Log out'];
  final List<int> index = [1, 2, 3, 4, 5];


  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    TextEditingController currPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmedPassword = TextEditingController();
    String curr = '';
    String newp = '';
    String confirmed = '';
    var _isLoading = false;

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

    Future<void> loggingOut() async {
      Map<String, dynamic> data = {
        'message': '',
        'success': '',
      };
      setState(() {
        _isLoading = true;
      });
      try {
        data = await Provider.of<Auth>(context, listen: false).logout() as Map<String, dynamic>;
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not log you out. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      print(data);
      if (data['success'] == true) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => new AuthPage(title: 'AuthPage')));
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
              children: <Widget> [
                Expanded (
                    flex: 10,
                    child: Row(
                      children: <Widget> [
                        Expanded(
                            flex: 50,
                            child: SafeArea(
                              child:  Image.asset(
                                "assets/images/frame10.png",
                                height: Constants.imageHeight(context),
                                width: Constants.imageWidth(context),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 50,
                            child: SafeArea(
                              child:  Image.asset(
                                "assets/images/frame10.png",
                                height: Constants.imageHeight(context),
                                width: Constants.imageWidth(context),
                              ),
                            )
                        ),
                      ],
                    )
                ),
                SizedBox(height:screenTab(context)/2),
                Expanded (
                  flex: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                    children: [
                      Expanded (
                        flex: 40,
                        child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                            Text("Change profile information",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeSmall(context),
                              ),
                            ),
                            TextFormField(
                              initialValue: _initValues['name'],
                              decoration: InputDecoration(labelText: 'Name'),
                              maxLines: 1,
                            ),
                            TextFormField(
                              initialValue: _initValues['dob'],
                              decoration: InputDecoration(labelText: 'Date of birth'),
                              maxLines: 1,
                            ),
                            TextFormField(
                              initialValue: _initValues['ps'],
                              decoration: InputDecoration(labelText: 'Personal statement'),
                              maxLines: 1,
                            ),
                            ElevatedButton(
                                onPressed: () {  },
                                style: ElevatedButton.styleFrom(
                                  primary: Constants.appColor,
                                  fixedSize: Size(middleTab(context), buttonHeight(context)),
                                ),
                                child: Text("Save profile",
                                  style: TextStyle(fontSize: Constants.fontSizeNormal(context)),
                                )
                            ),
                          ]
                          )
                        )
                      ),
                      SizedBox(height:screenTab(context)/2),
                      Expanded (
                        flex: 40,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text("Change password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              ),
                              TextFormField(
                                initialValue: _initValues['dob'],
                                decoration: InputDecoration(labelText: 'Date of birth'),
                                maxLines: 1,
                              ),
                              TextFormField(
                                initialValue: _initValues['dob'],
                                decoration: InputDecoration(labelText: 'Date of birth'),
                                maxLines: 1,
                              ),
                              TextFormField(
                                initialValue: _initValues['dob'],
                                decoration: InputDecoration(labelText: 'Date of birth'),
                                maxLines: 1,
                              ),
                              ElevatedButton(
                                onPressed: () {  },
                                style: ElevatedButton.styleFrom(
                                  primary: Constants.appColor,
                                  fixedSize: Size(middleTab(context), buttonHeight(context)),
                                ),
                                child: Text("Save password",
                                  style: TextStyle(fontSize: fontSizeNormal(context)),
                                )
                              ),
                            ]
                          )
                        )
                      ),
                      SizedBox(height:screenTab(context)/2),
                      Expanded (
                        flex: 7,
                        child: ElevatedButton(
                          onPressed: () {  },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.appColor,
                            fixedSize: Size(middleTab(context), buttonHeight(context)),
                          ),
                          child: Text("Privacy Policy",
                            style: TextStyle(fontSize: fontSizeNormal(context)),
                          )
                        ),
                      ),
                      SizedBox(height:screenTab(context)/2),
                      Expanded (
                        flex: 7,
                        child: ElevatedButton(
                          onPressed: () { loggingOut(); },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.appColor,
                            fixedSize: Size(buttonWidth(context), buttonHeight(context)),
                          ),
                          child: Text("Log Out",
                            style: TextStyle(fontSize: fontSizeNormal(context)),
                          )
                        ),
                      )
                    ],
                  )
                ),
              ]
          )
        ),
      )
    );
  }
}
