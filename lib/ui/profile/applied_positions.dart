import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/splitted_view_screen.dart';
import 'package:intl/intl.dart';

import '../constants.dart';


class AppliedPosition extends StatefulWidget {
  final int idx;
  AppliedPosition(this.idx);

  @override
  State<AppliedPosition> createState() => _AppliedPositionState();
}

class _AppliedPositionState extends State<AppliedPosition> {
  @override
  Widget build(BuildContext context){
    final ap = Provider.of<ProviderUser>(context).findById(this.widget.idx);

    return GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(ap.companyName,
              style: TextStyle(
                color: appColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSizeExtraSmall(context),
              ),
            ),
            Text(ap.positionName,
              style: TextStyle(
                color: appColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSizeExtraSmall(context),
              ),
            ),
            Text(ap.status,
              style: TextStyle(
                color: appColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSizeExtraSmall(context),
              ),
            ),
            Text('${ DateFormat('MM/dd/yyyy').format(ap.dateTime)}',
              style: TextStyle(
                color: appColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSizeExtraSmall(context),
              ),
            ),
          ]
        ),
        footer: Container(
            padding: EdgeInsets.only(top: screenTab(context)*4),
            child: GridTileBar(
                backgroundColor: appColor,
                title: Text(" "),
                leading: IconButton(
                  icon: Icon(Icons.thumb_down_outlined),
                  onPressed: () => {},
                ),
                trailing: IconButton(
                  icon: Icon(Icons.thumb_up_outlined),
                  onPressed: () => {},
                )
            )
        )
    );
  }
}