import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import '../constants.dart';
import 'add_skill_form.dart';

class AddExperienceForm extends StatefulWidget {
  final String resumeId;
  final String sectionId;

  AddExperienceForm(this.resumeId, this.sectionId);
  @override
  _AddExperienceFormState createState() => _AddExperienceFormState();
}

class _AddExperienceFormState extends State<AddExperienceForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController cityStateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final titleFN = FocusNode();
  final placeFN = FocusNode();
  final cityStateFN = FocusNode();
  final countryFN = FocusNode();
  final startFN = FocusNode();
  final endFN = FocusNode();
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
    placeFN.dispose();
    cityStateFN.dispose();
    countryFN.dispose();
    startFN.dispose();
    endFN.dispose();
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
    else if (_addData['place'] == ''){
      _showErrorDialog("Place can't be empty");
    }
    else if (_addData['city_state'] == ''){
      _showErrorDialog("City State can't be empty");
    }
    else if (_addData['country'] == ''){
      _showErrorDialog("Country can't be empty");
    }
    else if (_addData['start_date'] == ''){
      _showErrorDialog("Start date can't be empty");
    }
    else if (_addData['end_date'] == ''){
      _showErrorDialog("End date can't be empty");
    }
    else {
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).addExperience(
            this.widget.resumeId, this.widget.sectionId, addData, true
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
                focusNode: placeFN,
                controller: placeController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Company',
                ),
                onChanged: (text) {
                  setState(() { addData['place'] = text; });
                },
              ),
              TextField(
                focusNode: cityStateFN,
                controller: cityStateController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'City State (City - State)',
                ),
                onChanged: (text) {
                  setState(() { addData['city_state'] = text; });
                },
              ),
              TextField(
                focusNode: countryFN,
                controller: countryController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Country',
                ),
                onChanged: (text) {
                  setState(() { addData['country'] = text; });
                },
              ),
              TextField(
                focusNode: startFN,
                controller: startDateController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Start Date (mm/dd/yyyy)',
                ),
                onChanged: (text) {
                  setState(() { addData['start_date'] = text; });
                },
              ),
              TextField(
                focusNode: endFN,
                controller: endDateController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'End Date (mm/dd/yyyy)',
                ),
                onChanged: (text) {
                  setState(() { addData['end_date'] = text; });
                },
              ),
              TextField(
                focusNode: descriptionFN,
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter each line by line',
                  border: null,
                  labelText: 'Description',
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