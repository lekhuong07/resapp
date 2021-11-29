import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import '../constants.dart';
import '../../models/dummy_position.dart';
import 'position_list_view.dart';

class PositionPage extends StatefulWidget{
  const PositionPage({Key? key, required this.positions}): super(key: key);
  final List<Position> positions;

  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  TextEditingController nameController = TextEditingController();
  String posName = '';
  var _isLoading = false;
  var _isInit = true;

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

  Future<void> _submitAddAPosition(resumeId) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
    };
    setState(() {
      _isLoading = true;
    });
    if(resumeId == '' ){
      _showErrorDialog("Resume name can't be empty");
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PositionPage(positions: [],)),
      );
    }
    else {
      try {
        data = await Provider.of<ProviderPositions>(context, listen: false)
            .addPosition(resumeId) as Map<String, dynamic>;
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PositionPage(positions: [],)),
      );
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProviderPositions>(context).fetchAndSetResume().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProviderUser>(context).userProfile;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? Center(child: CircularProgressIndicator()) :
      SafeArea(
          child: Column(
              children: <Widget> [
                Expanded (
                  flex: 25,
                  child: SafeArea(
                      child: (
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Expanded(
                              flex: 30,
                              child:  Image.asset(
                                "assets/images/frame10.png",
                                height: imageHeight(context),
                                width: imageWidth(context),
                              ),
                            ),
                            Expanded(
                                flex:70,
                                child: Column (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget> [
                                    Text(userProfile.fullname,
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
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: fontSizeSmall(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            )
                          ],
                        )
                      )
                  )
                ),
                Expanded(
                  flex: 15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        Expanded(
                          flex: 80,
                          child: Padding(
                              padding: EdgeInsets.only(left: midWidth(context)/2),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Add a new resume',
                                ),
                                onChanged: (text) {
                                  setState(() { posName = text; });
                                },
                              )
                          ),
                        ),
                        Expanded(
                            flex: 20,
                            child: SizedBox(
                              height: double.infinity,
                              child: TextButton(
                                onPressed: () { _submitAddAPosition(posName); },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  fixedSize: Size(iconSize(context), buttonHeight(context)),
                                ),
                                child: Icon(Icons.post_add, color: appColor, size: fontSizeBig(context))
                              )
                            )
                        ),
                      ]
                  )
                ),
                Expanded (
                  flex: 60,
                  child: PositionListView(),
                ),
              ]
          )
        )
      ),
    );
  }
}



