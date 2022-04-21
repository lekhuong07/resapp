import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/auth_provider.dart';
import '../constants.dart' as Constants;
import '../constants.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _isInit = true;
  var _isLoading = false;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();

  var _resetPassword = {
    'email': '',
  };

  String mergeString(List<String> inputString){
    String result = '';
    for (int i = 0; i < inputString.length; i ++){
      result += inputString[i] + "\n";
    }
    return result;
  }


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

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

  Future<void> _submitEditPassword(_editPassword) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    setState(() {
      _isLoading = true;
    });
    if(_editPassword['newPassword'] == ''){
      print("New password is empty");
      _showErrorDialog("Name can't be empty");
    }
    else if(_editPassword['confirmed'] == ''){
      print("Confirmed new password is empty");
      _showErrorDialog("Date of birth can't be empty");
    }
    else {
      try {
        data = await Provider.of<Auth>(context, listen: false).resetPassword(
            _resetPassword
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
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                              onPressed: () { Navigator.pop(context); },
                              child: Icon(Icons.arrow_back_outlined , color: appColor)
                          ),
                          TextButton(
                              onPressed: () {
                                _submitEditPassword(_resetPassword);
                              },
                              child: Icon(Icons.save_outlined , color: appColor)
                          ),
                        ],
                      ),
                      Text("Change password",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeSmall(context),
                        ),
                      ),
                      SizedBox(height: screenTab(context)),
                      TextField(
                        controller: newPassword,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Email',
                        ),
                        onChanged: (text) {
                          setState(() { _resetPassword['email'] = text; });
                        },
                      ),
                    ]
                )
            )
         )
      )
    );
  }
}
