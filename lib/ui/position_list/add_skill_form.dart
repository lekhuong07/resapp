import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position_provider.dart';

import '../constants.dart';
import 'add_experience_form.dart';

class AddSkillForm extends StatefulWidget {
  final String resumeId;
  final String sectionId;

  AddSkillForm(this.resumeId, this.sectionId);
  @override
  _AddSkillFormState createState() => _AddSkillFormState();
}

class _AddSkillFormState extends State<AddSkillForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final titleFN = FocusNode();
  final descriptionFN = FocusNode();

  var _isLoading = false;
  var _isInit = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    titleFN.dispose();
    descriptionFN.dispose();
    super.dispose();
  }

  Map<String, String> addData = {
    'title': '',
    'place': '',
    'city_state': '',
    'country': '',
    'start_date': '',
    'end_date': '',
    'description': ''
  };

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

  Future<void> _submitAddExperience(_addData) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    setState(() {
      _isLoading = true;
    });
    if(_addData['title'] == ''){
      _showErrorDialog("Title can't be empty");
    }
    else {
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).addExperience(
            this.widget.resumeId, this.widget.sectionId, addData, false
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
    return SingleChildScrollView(
        child: Column(
            children: <Widget>[
              TextField(
                focusNode: titleFN,
                controller: titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Title',
                ),
                onChanged: (text) {
                  setState(() { addData['title'] = text; });
                },
              ),
              TextField(
                focusNode: descriptionFN,
                controller: descriptionController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Description (separate by comma)',
                ),
                onChanged: (text) {
                  setState(() { addData['description'] = text; });
                },
              ),
              ElevatedButton(
                  onPressed: () { _submitAddExperience(addData); },
                  style: ElevatedButton.styleFrom(
                    primary: appColor,
                    fixedSize: Size(buttonWidth(context), buttonHeight(context)),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: fontSizeNormal(context)),
                  )
              ),
            ]
        )
    );
  }
}