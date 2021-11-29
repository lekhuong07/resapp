import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resapp/models/position.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/ui/position_list/position_editor.dart';
import 'package:resapp/ui/position_list/position_screen.dart';

import '../constants.dart';

class PositionListView extends StatefulWidget {
  const PositionListView({
    Key? key,
  }) : super(key: key);

  @override
  State<PositionListView> createState() => _PositionListViewState();
}

class _PositionListViewState extends State<PositionListView> {
  var _isLoading = false;
  @override
  void initState(){
    super.initState();
  }

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

  Future<void> _submitDeletePosition(resumeId) async {
    Map<String, dynamic> data = {
      'status': '',
      'success': ''
    };
    setState(() {
      _isLoading = true;
    });
    try {
      data = await Provider.of<ProviderPositions>(context, listen: false).deletePosition(
          resumeId ) as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
     Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    void selectPosition (BuildContext ctx, int index){
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return PositionEditor();
          },
          settings: RouteSettings(  arguments: index, ),
        ),
      );
    }

    final productData = Provider.of<ProviderPositions>(context);
    final products = productData.items;
    return ListView.separated(
      padding: EdgeInsets.only(left: screenTab(context), right: screenTab(context)),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            onDismissed: (direction) { _submitDeletePosition(products[index].dataId); },
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
          child: ElevatedButton(
            onPressed: () => selectPosition(context, index),
            style: ElevatedButton.styleFrom(
              primary: appColor,
              fixedSize: Size(middleTab(context), buttonHeight(context)),
            ),
            child: Center(
                child: Text('${products[index].title}',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeSmall(context),
                  ),
                )
            )
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
