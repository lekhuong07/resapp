import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/ui/position_list/position_screen.dart';
import '../constants.dart';

class ExperienceEditor extends StatefulWidget {
  final String resumeId;
  final String sectionId;
  final String sectionTitle;
  final Experience exp;
  ExperienceEditor(this.resumeId, this.sectionId, this.sectionTitle, this.exp);
  @override
  _ExperienceEditorState createState() => _ExperienceEditorState();
}

class _ExperienceEditorState extends State<ExperienceEditor> {
  TextEditingController sectionTitleController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController cityStateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var editData = {
    'title': '',
    'place': '',
    'city_state': '',
    'country': '',
    'start_date': '',
    'end_date': '',
    'description': '',
  };

  var editSection = {
    'section_name': ''
  };


  @override
  void didChangeDependencies() {
    if (_isInit) {
      editSection['section_name'] = this.widget.sectionTitle;
      editData['title'] = this.widget.exp.title;
      editData['place'] = this.widget.exp.place;
      editData['city_state'] = this.widget.exp.cityState;
      editData['country'] = this.widget.exp.country;
      editData['start_date'] = this.widget.exp.startDate;
      editData['end_date'] = this.widget.exp.endDate;
      editData['description'] = mergeString(this.widget.exp.description);

      sectionTitleController.text = this.widget.sectionTitle;
      titleController.text = this.widget.exp.title;
      placeController.text = this.widget.exp.place;
      cityStateController.text = this.widget.exp.cityState;
      countryController.text = this.widget.exp.country;
      startDateController.text = this.widget.exp.startDate;
      endDateController.text = this.widget.exp.endDate;
      descriptionController.text = mergeString(this.widget.exp.description);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final sectionTitleFN = FocusNode();
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
    sectionTitleFN.dispose();
    titleFN.dispose();
    placeFN.dispose();
    cityStateFN.dispose();
    countryFN.dispose();
    startFN.dispose();
    endFN.dispose();
    descriptionFN.dispose();
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

  Future<void> _submitEditExperience(_editSection, _editData) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    setState(() {
      _isLoading = true;
    });
    if(_editSection['section_name'] == ''){
      _showErrorDialog("Section name can't be empty");
    }
    else if(_editData['title'] == ''){
      _showErrorDialog("Title can't be empty");
    }
    else if (_editData['place'] == ''){
      _showErrorDialog("Place can't be empty");
    }
    else if (_editData['city_state'] == ''){
      _showErrorDialog("City State can't be empty");
    }
    else if (_editData['country'] == ''){
      _showErrorDialog("Country can't be empty");
    }
    else if (_editData['start_date'] == ''){
      _showErrorDialog("Start date can't be empty");
    }
    else if (_editData['end_date'] == ''){
      _showErrorDialog("End date can't be empty");
    }
    else {
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).editSection(
            this.widget.resumeId, this.widget.sectionId, _editSection['section_name']
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

      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).editExperience(
            this.widget.resumeId, this.widget.sectionId, this.widget.exp.dataId, _editData, true
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

      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PositionPage(positions: [],)),
      );
    }
  }

  String mergeString(List<String> inputString){
    String result = '';
    for (int i = 0; i < inputString.length; i ++){
      result += inputString[i] + "\n";
    }
    return result;
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
                    onPressed: () {
                      _submitEditExperience( editSection, editData );
                    },
                    child: Icon(Icons.save_outlined , color: appColor)
                  ),
                ],
              ),
              Text("Section",
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeSmall(context),
                ),
              ),
              TextField(
                focusNode: sectionTitleFN,
                controller: sectionTitleController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Section name',
                ),
                onChanged: (text) {
                  setState(() { editData['section_name'] = text; });
                },
              ),
              SizedBox(height: screenTab(context)),
              Text("Experience",
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeSmall(context),
                ),
              ),
              TextField(
                focusNode: titleFN,
                controller: titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: null,
                  labelText: 'Title',
                ),
                onChanged: (text) {
                  setState(() { editData['title'] = text; });
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
                  setState(() { editData['place'] = text; });
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
                  setState(() { editData['city_state'] = text; });
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
                  setState(() { editData['country'] = text; });
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
                  setState(() { editData['start_date'] = text; });
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
                  setState(() { editData['end_date'] = text; });
                },
              ),
              TextField(
                focusNode: descriptionFN,
                controller: descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter each line by line',
                  border: null,
                  labelText: 'Description',
                ),
                onChanged: (text) {
                  setState(() { editData['description'] = text; });
                },
              ),
            ]
          )
        )
      )
    );
  }
}