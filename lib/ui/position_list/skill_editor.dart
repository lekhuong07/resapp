import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/ui/position_list/position_screen.dart';
import '../constants.dart';

class SkillEditor extends StatefulWidget {
  final String resumeId;
  final String sectionId;
  final String sectionTitle;
  final Skill skl;
  SkillEditor(this.resumeId, this.sectionId, this.sectionTitle, this.skl);
  @override
  _SkillEditorState createState() => _SkillEditorState();
}

class _SkillEditorState extends State<SkillEditor> {
  var _isInit = true;

  var _editSectionData = {
    'section_name': ''
  };

  var _editSklData = {
    'title': '',
    'description': '',
  };
  TextEditingController sectionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
      _editSectionData['section_name'] = this.widget.sectionTitle;
      _editSklData['title'] = this.widget.skl.title;
      _editSklData['description'] = mergeString(this.widget.skl.description);

      sectionController.text = this.widget.sectionTitle;
      titleController.text = this.widget.skl.title;
      descriptionController.text = mergeString(this.widget.skl.description);
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

  Future<void> _submitEditSkill(_editSection, _editData) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    if(_editSection['section_name'] == ''){
      _showErrorDialog("Section name can't be empty");
    }
    else if(_editData['title'] == ''){
      _showErrorDialog("Title can't be empty");
    }
    else {
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).editSection(
            this.widget.resumeId, this.widget.sectionId, _editSection['section_name']
        ) as Map<String, dynamic>;
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }

      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).editExperience(
            this.widget.resumeId, this.widget.sectionId, this.widget.skl.dataId, _editData, false
        ) as Map<String, dynamic>;
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
                                _submitEditSkill( _editSectionData, _editSklData );
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
                        controller: sectionController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Section name',
                        ),
                        onChanged: (text) {
                          setState(() { _editSectionData['section_name'] = text; });
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
                        controller: titleController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: null,
                          labelText: 'Title',
                        ),
                        onChanged: (text) {
                          setState(() { _editSklData['title'] = text; });
                        },
                      ),
                      TextField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter each line by line',
                          border: null,
                          labelText: 'Description',
                        ),
                        onChanged: (text) {
                          setState(() { _editSklData['description'] = text; });
                        },
                      ),
                    ]
                )
            )
        )
    );
  }
}