import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/recommendation_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/position_item.dart';
import '../constants.dart';

class TipsResultPage extends StatefulWidget{
  final data;
  TipsResultPage(this.data);
  @override
  _TipsResultPage createState() => _TipsResultPage();
}

class _TipsResultPage extends State<TipsResultPage> {
  var _isLoading = false;
  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProviderUser>(context).userProfile;
    final similarities = this.widget.data['similarity'];
    final keywords = this.widget.data['keywords'];
    print(similarities);
    print(keywords);
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
                ],
              )
          ),
              Expanded (
                  flex: 50,
                  child: Row(
                      children: <Widget> [
                        Expanded (
                          flex: 50,
                          child: Column(
                              children: <Widget> [
                                Expanded (
                                  flex: 10,
                                  child: Text("Keywords:",
                                    style: TextStyle(
                                      color: appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeNormal(context),
                                    ),
                                  ),
                                ),
                                Expanded (
                                    flex: 90,
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                      itemCount: keywords.length,
                                      itemBuilder: (context, idx) {
                                        return Text(keywords[idx],
                                            style: TextStyle(
                                              color: appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontSizeExtraSmall(context),
                                            )
                                        );
                                      },
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: screenTab(context)/10
                                      ),
                                    )
                                )
                              ]
                          ),
                        ),
                        Expanded (
                          flex: 50,
                          child: Column(
                              children: <Widget> [
                                Expanded (
                                  flex: 10,
                                  child: Text("Similarity:",
                                    style: TextStyle(
                                      color: appColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeNormal(context),
                                    ),
                                  ),
                                ),
                                Expanded (
                                    flex: 90,
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                                      itemCount: similarities.length,
                                      itemBuilder: (context, idx) {
                                        return Text(similarities[idx],
                                            style: TextStyle(
                                              color: appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontSizeExtraSmall(context),
                                            )
                                        );
                                      },
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                      ),
                                    )
                                )
                              ]
                          ),
                        ),
                      ]
                  )
              ),
          ]
        )
      )
    );
  }
}
