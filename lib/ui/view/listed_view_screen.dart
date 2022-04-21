import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/position_list/position_list_view.dart';
import 'package:resapp/ui/view/skill_view.dart';

import '../constants.dart';
import 'experience_view.dart';

class ListViewPage extends StatefulWidget{
  const ListViewPage({Key? key}): super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  int clickedIndex = -1;

  @override
  void initState(){
    super.initState();
    clickedIndex = 0;
  }

  @override
  void dipose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void toggleListExperienceData(Position p, int clickedIdx){
      for(var i = 0; i < p.section.length; i++){
        bool currStatus = p.section[i].isChosen;
        if (i == clickedIdx){
          p.section[i].toggleShowHide(!currStatus);
        }
      }
    }

    final userProfile = Provider.of<ProviderUser>(context).userProfile;
    final positionId = ModalRoute.of(context)!.settings.arguments as int;
    final pos = Provider.of<ProviderPositions>(context, listen: false).findById(positionId);

    List<Section> section = pos.section;
    return Scaffold(
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
                    flex: 75,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                      itemCount: section.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Center(
                              child: Text('${section[index].name}',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeSmall(context),
                                ),
                              )
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: section[index].experience.length > 0 ? section[index].experience.length : section[index].skill.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                        margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                        child: section[index].experience.length > 0 ?
                                        ExperienceViewPage(context, section[index].experience[i]) :
                                        SkillViewPage(context, section[index].skill[i])
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(color: appColor),
                            ),
                          ]
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    )
                ),
              ]
          )
      ),
    );
  }
}