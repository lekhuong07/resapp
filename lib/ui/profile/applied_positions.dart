import 'dart:io';

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

  Future<void> _submitUpdateApplication(_data, applicationId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    try {
        data = await Provider.of<ProviderUser>(context, listen: false).updateApplication(
            _data, applicationId
        ) as Map<String, dynamic>;
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      if (data['success'] == true) {
        Navigator.pushNamed(context, '/profile');
      }
  }

  Future<void> _submitDeleteApplication(applicationId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    try {
      data = await Provider.of<ProviderUser>(context, listen: false).deleteApplication(
          applicationId
      ) as Map<String, dynamic>;
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    if (data['success'] == true) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context){
    final ap = Provider.of<ProviderUser>(context).findById(this.widget.idx);

    return Dismissible(
        onDismissed: (direction) { _submitDeleteApplication(ap.id); },
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                  'Do you want to remove the application?',
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
            );
          },
          child: GridTile(
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
                Text(ap.dateTime,
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
                      onPressed: () => {_submitUpdateApplication('denied', ap.id)},
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.thumb_up_outlined),
                      onPressed: () => {_submitUpdateApplication('success', ap.id)},
                    )
                )
            ),
          )
    );
  }
}