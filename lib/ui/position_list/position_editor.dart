import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/position_list/position_screen.dart';
import 'package:resapp/ui/position_list/skill_editor.dart';
import 'package:resapp/ui/view/experience_view.dart';
import 'package:resapp/ui/view/skill_view.dart';

import '../constants.dart';
import 'add_experience_form.dart';
import 'add_skill_form.dart';
import 'experience_editor.dart';

class PositionEditor extends StatefulWidget{
  const PositionEditor({Key? key}): super(key: key);
  @override
  _PositionEditorState createState() => _PositionEditorState();
}

class _PositionEditorState extends State<PositionEditor> {
  TextEditingController sectionName = TextEditingController();
  String sectionStr = '';

  int clickedIndex = -1;
  bool isExpPressed = false;
  bool isSkillPressed = false;
  bool _editData = true;
  bool _editSection = true;
  bool dataShown = false;

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

  Future<void> _submitDeleteSection(resumeId, sectionId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    if (sectionId == ''){
      _showErrorDialog('Please click on section that you want to delete');
    }
    else{
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false).deleteSection(
            resumeId, sectionId
        ) as Map<String, dynamic>;
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    }
     Navigator.pushNamed(context, '/profile');
  }

  Future<void> _submitAddSection(resumeId, name) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    print(name);
    if(name == ''){
      _showErrorDialog("Section name can't be empty");
    }
    else {
      print(resumeId);
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false)
            .addSection(resumeId, name) as Map<String, dynamic>;
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

  Future<void> _submitDeleteExp(resumeId, sectionId, experienceId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    if (sectionId == '') {
      _showErrorDialog('Please click on section that you want to delete');
    }
    else if (experienceId == '') {
      _showErrorDialog(
          'Please click on experience/skill that you want to delete');
    }
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false)
            .deleteExperience(
            resumeId, sectionId, experienceId, true
        ) as Map<String, dynamic>;
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PositionPage(positions: [],)),
      );
  }

  Future<void> _submitDeleteSkill(resumeId, sectionId, experienceId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    if (sectionId == '') {
      _showErrorDialog('Please click on section that you want to delete');
    }
    else if (experienceId == '') {
      _showErrorDialog(
          'Please click on experience/skill that you want to delete');
    }
    try {
      data = await Provider.of<ProviderPositions>(context, listen: false).deleteExperience(
          resumeId, sectionId, experienceId, false
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


  @override
  void initState(){
    super.initState();
    clickedIndex = 0;
    isExpPressed = false;
    isSkillPressed = false;
    dataShown=false;
  }

  @override
  void dipose(){
    print("Close");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var _initValues = {
      'name': 'KL',
      'dob': '02/16/1997',
      'ps': 'FKU',
    };

    void navigateEditExperience(BuildContext ctx, String resumeId, String sectionId, String sectionTitle, Experience exp){
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return ExperienceEditor(resumeId, sectionId, sectionTitle, exp);
          },
        ),
      );
    }
    void navigateSkillExperience(BuildContext ctx, String resumeId, String sectionId, String sectionTitle, Skill sk){
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return SkillEditor(resumeId, sectionId, sectionTitle, sk);
          },
        ),
      );
    }

    void toggleSplitExperienceData(Position p, int clickedIdx){
      for(var i = 0; i < p.section.length; i++){
        bool currStatus = p.section[i].isChosen;
        if (i == clickedIdx){
          p.section[i].toggleShowHide(!currStatus);
        }
        else{
          p.section[i].toggleShowHide(false);
        }
      }
    }

    final positionId = ModalRoute.of(context)!.settings.arguments as int;
    final pos = Provider.of<ProviderPositions>(
      context,
      listen: false,
    ).findById(positionId);

    final userProfile = Provider.of<ProviderUser>(context).userProfile;

    List<Section> section = pos.section;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              children: <Widget> [
                Expanded (
                    flex: 20,
                    child: Column (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Text(pos.title,
                            style: TextStyle(
                              color: appColor,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeNormal(context),
                            ),
                          ),
                          Container(
                            child: Text(userProfile.ps,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: fontSizeSmall(context),
                              ),
                            ),
                          ),
                        ],
                      )
                ),
                Expanded (
                    flex: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded (
                          flex: 35,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _editSection = !_editSection;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        fixedSize: Size(iconSize(context), buttonHeight(context)),
                                      ),
                                      child: Icon(Icons.post_add, color: _editSection ? appColor: Colors.grey, size: fontSizeBig(context))
                                  ),
                                  _editSection ? Text("") : Text("Edit mode"),
                                  _editSection ? Column (
                                    children: <Widget> [
                                      TextField(
                                        controller: sectionName,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Section Name',
                                        ),
                                        onChanged: (text) {
                                          setState(() { sectionStr = text; });
                                        },
                                      ),
                                      ElevatedButton(
                                          onPressed: () { _submitAddSection(pos.dataId, sectionStr); },
                                          style: ElevatedButton.styleFrom(
                                            primary: appColor,
                                            fixedSize: Size(buttonWidth(context), buttonHeight(context)),
                                          ),
                                          child: Text("Add",
                                            style: TextStyle(fontSize: fontSizeNormal(context)),
                                          )
                                      )
                                    ]
                                  ): Text(""),
                                ]
                              ),
                              _editSection ? Text("") : Expanded (
                                flex: 80,
                                child: ListView.separated(
                                  itemCount: section.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Dismissible(
                                      onDismissed: (direction) { _submitDeleteSection(pos.dataId, section[index].dataId); },
                                      key: Key(section[index].dataId),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) {
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                        title: Text('Are you sure?'),
                                        content: Text(
                                          'Do you want to remove the section?',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('No'),
                                            onPressed: () {  Navigator.of(ctx).pop(false); },
                                          ),
                                          TextButton(
                                            child: Text('Yes'),
                                            onPressed: () { Navigator.of(ctx).pop(true); },
                                          ),
                                        ],
                                        ),
                                      );
                                    },
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() { clickedIndex = index;  dataShown=true;});
                                          toggleSplitExperienceData(pos, clickedIndex);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(
                                                section[index].isChosen ? appColor : Colors.white
                                            )
                                        ),
                                        child: Row(
                                            children: <Widget> [
                                              Expanded(
                                                  flex: 22,
                                                  child: section[index].isChosen ?
                                                  Icon(Icons.arrow_circle_down_outlined , color: Colors.white) :
                                                  Icon(Icons.play_circle_outline_sharp  , color: Colors.black)
                                              ),
                                              Expanded(
                                                flex: 78,
                                                child:Text('${section[index].name}',
                                                  overflow: TextOverflow.visible,
                                                  style: new TextStyle(
                                                    backgroundColor: section[index].isChosen ? appColor : Colors.white,
                                                    color: section[index].isChosen ? Colors.white : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSizeExtraSmall(context),
                                                  ),
                                                ),
                                              ),
                                            ]
                                        )
                                      )
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                                ),
                              ),
                            ]
                          )
                        ),
                        Expanded(
                            flex: 65,
                            child: Column(
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    !_editSection ? setState(() { _editData= !_editData; }) :  null;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    fixedSize: Size(iconSize(context), buttonHeight(context)),
                                  ),
                                  child: Icon(Icons.post_add, color: _editData ? Colors.grey : appColor,  size: fontSizeBig(context))
                                ),
                                _editData ? Expanded(flex:10, child: Text("")) : Expanded(
                                  flex: 10,
                                  child: Row (
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      !_editSection && !_editData ? ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isExpPressed=true;
                                              isSkillPressed=false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isExpPressed ? appColor : Colors.white,
                                            fixedSize: Size(buttonWidth(context)*0.75, buttonHeight(context)),
                                          ),
                                          child: Text("EXP",
                                            style: TextStyle(
                                                color: isExpPressed ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeSmall(context)
                                            ),
                                          )
                                      ): Text(""),
                                      !_editSection && !_editData ? ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isExpPressed=false;
                                              isSkillPressed=true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isSkillPressed ? appColor : Colors.white,
                                            fixedSize: Size(buttonWidth(context)*0.75, buttonHeight(context)),
                                          ),
                                          child: Text("Skill",
                                            style: TextStyle(
                                              color: isSkillPressed ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontSizeSmall(context)
                                            ),
                                          )
                                      ) : Text("") ,
                                    ]
                                  )
                                ),
                                Expanded (
                                    flex: 60,
                                    child: !_editSection && _editData && section.length > 0
                                      ?Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: section[clickedIndex].isChosen,
                                      child: ListView.separated(
                                        itemCount: section[clickedIndex].experience.length > 0 ? section[clickedIndex].experience.length : section[clickedIndex].skill.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return section[clickedIndex].experience.length > 0 ? Dismissible(
                                              onDismissed: (direction) {
                                                _submitDeleteExp(
                                                    pos.dataId,
                                                    section[clickedIndex].dataId,
                                                    section[clickedIndex].experience[index].dataId,
                                                );
                                              },
                                              key: UniqueKey(),
                                              direction: DismissDirection.startToEnd,
                                              confirmDismiss: (direction) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text('Are you sure?'),
                                                    content: Text(
                                                      'Do you want to remove this experience/skill?',
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('No'),
                                                        onPressed: () {  Navigator.of(ctx).pop(false); },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yes'),
                                                        onPressed: () { Navigator.of(ctx).pop(true); },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                                  child:
                                                  GestureDetector(
                                                    onLongPress: () {
                                                        navigateEditExperience(
                                                          context,
                                                          pos.dataId,
                                                          section[clickedIndex].dataId,
                                                          section[clickedIndex].name,
                                                          section[clickedIndex].experience[index]
                                                        );
                                                      },
                                                    child: ExperienceViewPage(context, section[clickedIndex].experience[index])
                                                  )
                                              )
                                          ) : Dismissible(
                                              onDismissed: (direction) {
                                                _submitDeleteSkill(
                                                    pos.dataId,
                                                    section[clickedIndex].dataId,
                                                    section[clickedIndex].skill[index].dataId,
                                                );
                                              },
                                              key: UniqueKey(),
                                              direction: DismissDirection.startToEnd,
                                              confirmDismiss: (direction) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text('Are you sure?'),
                                                    content: Text(
                                                      'Do you want to remove this experience/skill?',
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('No'),
                                                        onPressed: () {  Navigator.of(ctx).pop(false); },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yes'),
                                                        onPressed: () { Navigator.of(ctx).pop(true); },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                                  child:
                                                  GestureDetector(
                                                      onLongPress: () {
                                                        navigateSkillExperience(
                                                            context,
                                                            pos.dataId,
                                                            section[clickedIndex].dataId,
                                                            section[clickedIndex].name,
                                                            section[clickedIndex].skill[index]
                                                        );
                                                      },
                                                      child: SkillViewPage(context, section[clickedIndex].skill[index])
                                                  )
                                                )
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) => const Divider(color: appColor),
                                      ),
                                    )
                                    :Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: isSkillPressed || isExpPressed,
                                      child: _editSection || !dataShown ? Text("") :
                                      (isSkillPressed ?
                                        AddSkillForm(pos.dataId ,section[clickedIndex].dataId):
                                        AddExperienceForm(pos.dataId ,section[clickedIndex].dataId)
                                      )
                                    ),
                                )
                             ]
                          )
                      ),
                   ]
                )
              ),
            ]
          )
        )
      )
    );
  }
}

