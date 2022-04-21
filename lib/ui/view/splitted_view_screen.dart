import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/skill_view.dart';
import '../constants.dart';
import 'experience_view.dart';

class SplitViewPage extends StatefulWidget{
  const SplitViewPage({Key? key}): super(key: key);

  @override
  State<SplitViewPage> createState() => _SplitViewPageState();
}

class _SplitViewPageState extends State<SplitViewPage> {
  int clickedIndex = -1;

  @override
  void initState(){
    super.initState();
    clickedIndex = 0;
  }

  @override
  void dipose(){
    print("Close");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
    final userProfile = Provider.of<ProviderUser>(context).userProfile;
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
                      child: section.length > 0 ? ListView.separated(
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
                     }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ): Center(
                        child: Text("Use 'Positions' tab to add sections",
                          overflow: TextOverflow.visible,
                          style: new TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontSize: fontSizeExtraSmall(context),
                          ),
                        ),
                      )
                    ),
                    section.length > 0 ? Expanded(
                      flex: 65,
                      child: Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: section[clickedIndex].isChosen,
                        child: ListView.separated(
                          itemCount: section[clickedIndex].experience.length > 0 ? section[clickedIndex].experience.length : section[clickedIndex].skill.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                child: section[clickedIndex].experience.length > 0 ?
                                     ExperienceViewPage(context, section[clickedIndex].experience[index]) :
                                     SkillViewPage(context, section[clickedIndex].skill[index])
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(color: appColor),
                        ),
                      )
                    ) : Center(
                        child: Text("Use 'Positions' tab to add experiences/skills",
                          overflow: TextOverflow.visible,
                          style: new TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontSize: fontSizeExtraSmall(context),
                          ),
                        ),
                      )
                  ]
                )
            ),
          ]
        )
      ),
    );
  }
}