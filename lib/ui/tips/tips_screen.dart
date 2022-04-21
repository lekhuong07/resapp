import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/recommendation_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/tips/tips_result.dart';
import '../constants.dart' as Constants;
import '../constants.dart';

class TipsPage extends StatefulWidget{
  const TipsPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  var _isLoading = false;

  var _jd = {
    'job_description': '',
  };

  TextEditingController descriptionController = TextEditingController();
  final descriptionFN = FocusNode();

  @override
  void dispose(){
    descriptionFN.dispose();
    super.dispose();
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

  void navigateChangeRecommendation(BuildContext ctx, Map<String, dynamic> data){
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return TipsResultPage(data);
        },
      ),
    );
  }

  Future<void> _submitRecommendation(BuildContext ctx, _jobData) async {
    Map<String, dynamic> data = {};
    setState(() {
      _isLoading = true;
    });
    if(_jobData['job_description'] == ''){
      _showErrorDialog("Job description can not be empty. Please make sure to have responsibilities, basic and preferred qualifications in case the job description is too long");
    }
    else {
      try {
        data = await Provider.of<ProviderRec>(context, listen: false).fetchRecommendation
          (_jobData) as Map<String, dynamic>;
        setState(() { _isLoading = false; });
        navigateChangeRecommendation(ctx, data);
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    }
  }

  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProviderUser>(context).userProfile;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              children: <Widget> [
                Expanded (
                    flex: 20,
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
                            maxLines: 5,
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
                ),
                Expanded (
                    flex: 10,
                    child: Text("Paste the job description you want to match with current resumes below then click get tips!",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: fontSizeSmall(context),
                      ),
                    ),
                ),
                Expanded (
                    flex: 65,
                    child: TextField(
                      focusNode: descriptionFN,
                      controller: descriptionController,
                      maxLength: 5000,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter each line by line',
                        border: null,
                        labelText: 'Job description',
                      ),
                      onChanged: (text) {
                        setState(() { _jd['job_description'] = text; });
                      },
                    ),
                ),
                Expanded (
                  flex: 5,
                  child: ElevatedButton(
                      onPressed: () {
                        _submitRecommendation(context, _jd);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Constants.appColor,
                        fixedSize: Size(middleTab(context), buttonHeight(context)),
                      ),
                      child: Text("Get tips!",
                        style: TextStyle(fontSize: fontSizeNormal(context)),
                      )
                  ),
                ),
              ]
          )
        ),
      )
    );
  }
}
