import 'package:flutter/material.dart';
import 'package:resapp/models/position.dart';

import '../constants.dart';

class SkillViewPage extends StatelessWidget{
  final Skill skill;
  SkillViewPage(context, this.skill);

  @override
  Widget build(BuildContext context) {
    String getDescription(List<String> des){
      if (des.length == 0){
        return "";
      }
      String result = "";
      for(var i = 0; i < des.length; i ++){
        result += "• " + des[i] + "\n";
      }
      return result;
    }
    return Column (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenTab(context) / 2,
                  height: screenTab(context) / 2,
                  decoration: BoxDecoration(
                    color: appColor,
                    shape: BoxShape.circle,
                  ),
                )
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: screenTab(context) / 2,
                  height: screenTab(context) / 2,
                  decoration: BoxDecoration(
                    color: appColor,
                    shape: BoxShape.circle,
                  ),
                )
            ),
          ],
        ),
        Text(skill.title,
          style: TextStyle(
            color: appColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSizeExtraSmall(context),
          ),
        ),
        Container(
          child:
          Text(getDescription(skill.description),
            overflow: TextOverflow.visible,
            style: new TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: fontSizeExtraSmall(context),
            ),
          ),
        ),
      ],
    );
  }
}
