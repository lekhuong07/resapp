import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class TipsPage extends StatefulWidget{
  const TipsPage({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final List<String> entries = <String>['Certifications', 'Education', 'Experience', 'Projects', 'Skills'];
  final List<int> index = [1, 2, 3, 4, 5];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              children: <Widget> [
                Expanded (
                    flex: 20,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                          Expanded(
                              flex: 30,
                              child: SafeArea(
                                child:  Image.asset(
                                  "assets/images/frame10.png",
                                  height: Constants.imageHeight(context),
                                  width: Constants.imageWidth(context),
                                ),
                              )
                          ),
                          Expanded(
                              flex:70,
                              child: SafeArea(
                                  child: Column (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget> [
                                      Text("Your Name Here",
                                        style: TextStyle(
                                          color: Constants.appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constants.fontSizeNormal(context),
                                        ),
                                      ),
                                      Container(
                                        child: Text("This should be a very very long statement about yourself, testing to see how long it could be looper.",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: Constants.fontSizeSmall(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                          )
                        ],
                      )
                    )
                ),
                Expanded (
                  flex: 80,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: Constants.screenTab(context)/2, right: Constants.screenTab(context)/2),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 85,
                              child: Center(
                                child: Text('${entries[index]}',
                                  overflow: TextOverflow.visible,
                                  style: new TextStyle(
                                    backgroundColor: Colors.white,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.fontSizeSmall(context),
                                  ),
                                ),
                              )
                          ),
                          Expanded(
                            flex: 15,
                            child: TextButton(
                                onPressed: () { },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  fixedSize: Size(Constants.iconSize(context), Constants.buttonHeight(context)),
                                ),
                                child: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black)
                            )
                          )
                        ],
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const Divider(),),
                ),
              ]
          )
      ),
    );
  }
}
