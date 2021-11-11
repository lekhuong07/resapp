import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
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

  void _addNewPosition(String inTitle, List<Section> inSection, int index){
    final newPosition = Position(
        title: inTitle,
        section: inSection,
        id: index
    );
    nameController.clear();
    setState(() {
      dummyPosition.add(newPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProviderUser>(context).userProfile;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                                  labelText: 'Add a new position',
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
                                onPressed: () {
                                  _addNewPosition(posName, <Section> [], dummyPosition.length);
                                },
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



