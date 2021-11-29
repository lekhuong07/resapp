import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/auth_provider.dart';
import 'package:resapp/models/http_exception.dart';
import 'package:resapp/models/user.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/authenticate/authenticate_screen.dart';
import '../constants.dart' as Constants;
import '../constants.dart';
import 'change_password.dart';
import 'change_profile.dart';

class SettingsPage extends StatefulWidget{
  final ProviderUser userProvider;
  SettingsPage(this.userProvider);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _isLoading = false;
  var _isInit = true;

  TextEditingController currPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProviderUser>(context).fetchAndSetUser().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void navigateChangeProfile(BuildContext ctx, User _userProfile){
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ProfileEditor(_userProfile);
        },
      ),
    );
  }

  void navigateEditPassword(BuildContext ctx, User _userProfile){
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return PasswordEditor(_userProfile);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    User userProfile = this.widget.userProvider.userProfile;
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
      try {
        data = await Provider.of<Auth>(context, listen: false).logout() as Map<String, dynamic>;
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
        body:  _isLoading ? Center(child: CircularProgressIndicator()): SafeArea(
          child: Column(
            children: <Widget> [
              Expanded (
                flex: 20,
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
                flex: 80,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: [
                    Expanded (
                    flex: 70,
                    child: GestureDetector(
                        onLongPress: () { navigateChangeProfile(context, userProfile); },
                        child: Column(
                            children: <Widget>[
                              Text("Change profile information",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              ),
                              SizedBox(height:screenTab(context)/2),
                              Text("Full name: ${userProfile.fullname}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              ),
                              SizedBox(height:screenTab(context)/2),
                              Text("Date of birth: ${userProfile.dob}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              ),
                              SizedBox(height:screenTab(context)/2),
                              Text("Personal statement: ${userProfile.ps}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              ),
                            ]
                        )
                    )
                ),
                  Expanded (
                    flex: 30,
                    child: Column(
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () { navigateEditPassword(context, userProfile); },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.appColor,
                                fixedSize: Size(middleTab(context), buttonHeight(context)),
                              ),
                              child: Text("Change password",
                                style: TextStyle(fontSize: fontSizeNormal(context)),
                              )
                          ),
                          SizedBox(height:screenTab(context)/2),
                          ElevatedButton(
                              onPressed: () { loggingOut(); },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.appColor,
                                fixedSize: Size(middleTab(context), buttonHeight(context)),
                              ),
                              child: Text("Log out",
                                style: TextStyle(fontSize: fontSizeNormal(context)),
                              )
                          ),
                        ]
                    )
                  )
                  ]
                )
              )
            ]
        )
        ),
      )
    );
  }
}
