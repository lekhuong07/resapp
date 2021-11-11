import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
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
                child: Row(
                    children: <Widget>[
                      Expanded (
                        flex: 35,
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
                      Expanded(
                        flex: 65,
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: section[clickedIndex].isChosen,
                          child: ListView.separated(
                            itemCount: section[clickedIndex].experience.length > 0 ? section[clickedIndex].experience.length : section[clickedIndex].skill.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(screenTab(context)*1.5),
                                child: Container(
                                  margin: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                  child: section[clickedIndex].experience.length > 0 ?
                                       ExperienceViewPage(context, section[clickedIndex].experience[index]) :
                                       SkillViewPage(context, section[clickedIndex].skill[index])
                                )
                             );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(color: appColor),
                          ),
                      )
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