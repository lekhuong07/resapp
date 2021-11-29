import 'package:flutter/material.dart';
import 'package:resapp/models/position.dart';

import '../constants.dart';

class ExperienceViewPage extends StatelessWidget{
  ExperienceViewPage(context, this.exp);
  final Experience exp;

  @override
  Widget build(BuildContext context) {
    String getDateTime(String startM, String startY, String endM, String endY, String split){
      String result = "";
      result += startM + " " + startY;
      result += split + endM + " " + endY;
      return result;
    }
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
          Text(exp.title,
            style: TextStyle(
              color: appColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSizeExtraSmall(context),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child:Text(exp.place,
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeExtraSmall(context),
                ),
              ),
            )
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                child:Text(getDateTime("", exp.cityState, exp.country, "", " - "),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeExtraSmall(context),
                  ),
                ),
              )
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: Text(getDateTime(exp.startDate, exp.endDate, "", "", " - "),
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeExtraSmall(context),
                ),
              )
            )
          ),
          Container(
            child:
            Text(getDescription(exp.description),
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
