import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/experience_view.dart';
import 'package:resapp/ui/view/skill_view.dart';

import '../constants.dart';
import 'add_experience_form.dart';
import 'add_skill_form.dart';

class PositionEditor extends StatefulWidget{
  const PositionEditor({Key? key}): super(key: key);
  @override
  _PositionEditorState createState() => _PositionEditorState();
}

class _PositionEditorState extends State<PositionEditor> {
  int clickedIndex = -1;
  bool isExpPressed = false;
  bool isSkillPressed = false;

  @override
  void initState(){
    super.initState();
    clickedIndex = 0;
    isExpPressed = false;
    isSkillPressed = false;
  }

  @override
  void dipose(){
    print("Close");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController sectionName = TextEditingController();
    String sectionStr = '';

    var _initValues = {
      'name': 'KL',
      'dob': '02/16/1997',
      'ps': 'FKU',
    };

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
                    flex: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        Expanded(
                            flex: 30,
                            child: SafeArea(
                              child:  Image.asset(
                                "assets/images/frame10.png",
                                height: imageHeight(context),
                                width: imageWidth(context),
                              ),
                            )
                        ),
                        Expanded(
                            flex:70,
                            child: SafeArea(
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
                                        maxLines: 4,
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
                            )
                        )
                      ],
                    )
                ),
                Expanded (
                    flex: 75,
                    child: Row(
                      children: <Widget>[
                        Expanded (
                          flex: 35,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () { },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        fixedSize: Size(iconSize(context), buttonHeight(context)),
                                      ),
                                      child: Icon(Icons.post_add, color: appColor, size: fontSizeBig(context))
                                  ),
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
                                ]
                              ),
                              Expanded (
                                flex: 80,
                                child: ListView.separated(
                                  itemCount: section.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return TextButton(
                                        onPressed: () {
                                          setState(() { clickedIndex = index;  });
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
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) => const Divider(),),
                              ),
                            ]
                          )
                        ),
                        Expanded(
                            flex: 65,
                            child: Column(
                              children: <Widget>[
                                TextButton(
                                  onPressed: () { },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    fixedSize: Size(iconSize(context), buttonHeight(context)),
                                  ),
                                  child: Icon(Icons.post_add, color: appColor, size: fontSizeBig(context))
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Row (
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ElevatedButton(
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
                                      ),
                                      ElevatedButton(
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
                                      ),
                                    ]
                                  )
                                ),
                                Expanded (
                                    flex: 60,
                                    child: Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: isSkillPressed || isExpPressed,
                                        child: isExpPressed ? AddExperienceForm(initValues: _initValues) : AddSkillForm(initValues: _initValues)
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

