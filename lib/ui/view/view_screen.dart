import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/models/user_provider.dart';
import 'package:resapp/ui/view/position_item.dart';
import '../constants.dart';
import 'position_item.dart';

class ViewPage extends StatefulWidget{
  const ViewPage({Key? key, required this.positions}): super(key: key);
  final List<Position> positions;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    final positionData = Provider.of<ProviderPositions>(context);
    final userProfile = Provider.of<ProviderUser>(context).userProfile;
    final dummyPosition = positionData.items;
    return Scaffold(
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
                flex: 80,
                child: GridView.builder(
                  padding: EdgeInsets.only(left: screenTab(context)/2, right: screenTab(context)/2),
                  itemCount: dummyPosition.length,
                  itemBuilder: (context, idx) => PositionItem(idx),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenTab(context)/2,
                    crossAxisSpacing: screenTab(context)/2
                  ),
                )
              ),
            ]
        )
      ),
    );
  }
}
