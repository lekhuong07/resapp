import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/position_list/position_screen.dart';
import 'package:resapp/ui/settings/settings_screen.dart';
import '../constants.dart';

class ProfileEditor extends StatefulWidget {
  final User userProfile;
  ProfileEditor(this.userProfile);
  @override
  _ProfileEditorState createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'name': '',
    'dob': '',
    'ps': '',
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController psController = TextEditingController();

  String mergeString(List<String> inputString){
    String result = '';
    for (int i = 0; i < inputString.length; i ++){
      result += inputString[i] + "\n";
    }
    return result;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _initValues['name'] = this.widget.userProfile.fullname;
      _initValues['dob'] = this.widget.userProfile.dob;
      _initValues['ps'] = this.widget.userProfile.ps;

      nameController.text = this.widget.userProfile.fullname;
      dobController.text = this.widget.userProfile.dob;
      psController.text = this.widget.userProfile.ps;
      print(_initValues);
    }
    _isInit = false;
    super.didChangeDependencies();
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

  Future<void> _submitEditProfile(_editProfile) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    setState(() {
      _isLoading = true;
    });
    if(_editProfile['name'] == ''){
      print("Name is empty");
      _showErrorDialog("Name can't be empty");
    }
    else if(_editProfile['dob'] == ''){
      print("DOB is empty");
      _showErrorDialog("Date of birth can't be empty");
    }
    else if (_editProfile['ps'] == ''){
      print("PS is empty");
      _showErrorDialog("Personal statement can't be empty");
    }
    else {
      try {
        data = await Provider.of<ProviderUser>(context, listen: false).updateProfile(
            _editProfile
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
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                              onPressed: () { _submitEditProfile(_initValues); },
                              child: Icon(Icons.save_outlined , color: appColor)
                          ),
                        ],
                      ),
                      Text("Profile information",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeSmall(context),
                        ),
                      ),
                      SizedBox(height: screenTab(context)),
                      TextField(
                        controller: nameController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Full name',
                        ),
                        onChanged: (text) {
                          setState(() { _initValues['name'] = text; });
                        },
                      ),
                      TextField(
                        controller: dobController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Date of birth',
                        ),
                        onChanged: (text) {
                          setState(() { _initValues['dob'] = text; });
                        },
                      ),
                      TextField(
                        controller: psController,
                        maxLength: 150,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Description',
                        ),
                        onChanged: (text) {
                          setState(() { _initValues['ps'] = text; });
                        },
                      ),
                    ]
                )
            )
        )
    );
  }
}