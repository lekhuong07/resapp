import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/user.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/position_item.dart';
import '../constants.dart';
import '../../models/dummy_position.dart';
import 'package:pie_chart/pie_chart.dart';

import 'applied_positions.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}): super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  String addProfile = '';
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState(){
    super.initState();
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
    final userProvider = Provider.of<ProviderUser>(context);
    User userProfile = userProvider.userProfile;
    Map<String, double> dataMap = userProvider.applicationMap();
    List<Color> colorList = [Colors.yellow, Colors.blue, Colors.red, Colors.green];
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _isLoading ? Center(child: CircularProgressIndicator()):
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
                        flex: 25,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              Expanded(
                                flex: 80,
                                child: Column(
                                  children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(labelText: 'Company'),
                                    maxLines: 1,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: 'Position'),
                                    maxLines: 1,
                                  ),
                                ]
                                )
                              ),
                              Expanded(
                                  flex: 20,
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: TextButton(
                                        onPressed: () {  },
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
                  flex: 50,
                  child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                    Container(
                        color: Colors.white,
                        height: screenTab(context)*1.5,
                        width: middleTab(context),
                        child: Text("Statistics: ",
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
