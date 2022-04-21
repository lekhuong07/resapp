import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/position_item.dart';
import '../constants.dart';
import '../../models/dummy_position.dart';
import 'package:pie_chart/pie_chart.dart';

import 'applied_positions.dart';

class ProfilePage extends StatefulWidget{
  final ProviderUser userProvider;
  ProfilePage(this.userProvider);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map<String, String> addApplicationData = {
    'company': '',
    'position': '',
  };
  TextEditingController companyController = TextEditingController();
  final _companyFocusNode = FocusNode();

  TextEditingController positionController = TextEditingController();
  final _positionFocusNode = FocusNode();


  var _isLoading = false;
  var _isInit = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _companyFocusNode.dispose();
    _positionFocusNode.dispose();
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

  Future<void> _submitAddApplication(_authData) async {
    Map<String, dynamic> data = {
      'message': '',
      'success': '',
      'email': ''
    };
    setState(() {
      _isLoading = true;
    });
    if(_authData['company'] == '' || _authData['position'] == ''){
      _showErrorDialog("Company and Position can't be empty");
      Navigator.pushNamed(context, '/profile');
    }
    else {
      try {
        data = await Provider.of<ProviderUser>(context, listen: false).addApplication(
            _authData['company'], _authData['position']
        ) as Map<String, dynamic>;
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
  }


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProviderUser>(context).fetchAndSetUser().then((_) {
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
    User userProfile = this.widget.userProvider.userProfile;
    Map<String, double> dataMap = this.widget.userProvider.applicationMap();
    List<Color> colorList = [Colors.yellow, Colors.blue, Colors.red, Colors.green];
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _isLoading ? Center(child: CircularProgressIndicator()) :
          SafeArea(
              child: Column(
                  children: <Widget> [
                    Expanded (
                      flex: 20,
                      child: SafeArea(
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
                        )
                    ),
                    Expanded(
                        flex: 25,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              Expanded(
                                flex: 80,
                                child: Column(
                                  children: <Widget>[
                                  TextField(
                                    focusNode: _companyFocusNode,
                                    controller: companyController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Company',
                                    ),
                                    onChanged: (text) {
                                      setState(() { addApplicationData['company'] = text; });
                                    },
                                  ),
                                  TextField(
                                    focusNode: _positionFocusNode,
                                    controller: positionController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Position',
                                    ),
                                    onChanged: (text) {
                                      setState(() { addApplicationData['position'] = text; });
                                    },
                                  )
                                  ]
                                )
                              ),
                              Expanded(
                                  flex: 20,
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: TextButton(
                                        onPressed: () { _submitAddApplication(addApplicationData); },
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
                  flex: 55,
                  child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                    Container(
                        color: Colors.white,
                        height: screenTab(context)*1.5,
                        width: middleTab(context),
                        child: Text('Statistics: (total: ${userProfile.apply.length})',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeSmall(context),
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenTab(context)/4),
                      child: PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 1000),
                        chartLegendSpacing: screenTab(context),
                        chartRadius: middleTab(context)/2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.disc,
                        ringStrokeWidth: middleTab(context)/4,
                        centerText: "Positions",
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                      ),
                    ),
                    GridView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                      itemCount: userProfile.apply.length,
                      itemBuilder: (context, idx) => AppliedPosition(idx),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: screenTab(context)/2,
                          crossAxisSpacing: screenTab(context)/2
                      ),
                    )
                  ],
                  )
                  )
                ),
            ]
          )
      ),
    )
    );
  }
}
