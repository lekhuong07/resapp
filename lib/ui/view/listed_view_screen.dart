import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
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
    print("Open");
  }

  @override
  void dipose(){
    print("Close");
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

    final positionId = ModalRoute.of(context)!.settings.arguments as int;
    final pos = Provider.of<ProviderPositions>(
      context,
      listen: false,
    ).findById(positionId);

    List<Section> section = pos.section;
    return Scaffold(
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
                                      child: Text("This should be a very very long statement about yourself, testing to see how long it could be looper.",
                                        maxLines: 3,
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
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(screenTab(context)*1.5),
                                    child: Container(
                                        margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                        child: section[index].experience.length > 0 ?
                                        ExperienceViewPage(context, section[index].experience[i]) :
                                        SkillViewPage(context, section[index].skill[i])
                                    )
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