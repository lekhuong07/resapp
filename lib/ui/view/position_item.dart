import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/ui/view/splitted_view_screen.dart';

import '../constants.dart';
import 'listed_view_screen.dart';

class PositionItem extends StatefulWidget {
  final int idx;
  PositionItem(this.idx);

  @override
  State<PositionItem> createState() => _PositionItemState();
}

class _PositionItemState extends State<PositionItem> {

  void viewSplitMode (BuildContext ctx, int posIdx){
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return SplitViewPage();
        },
        settings: RouteSettings(
          arguments: posIdx,
        ),
      ),
    );
  }

  void viewListMode (BuildContext ctx, int posIdx){
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ListViewPage();
        },
        settings: RouteSettings(
          arguments: posIdx,
        ),
      ),
    );
  }


  List<String> getSectionsDetail (Position pos) {
    List<String> res = <String> [];
    for (Section sec in pos.section) {
      res.add("+ " + sec.name + ":");
    }
    return res;
  }

  @override
  Widget build(BuildContext context){
    final pos = Provider.of<ProviderPositions>(context)
        .items
        .firstWhere((prod) => prod.id == this.widget.idx);
    final List<String> positionDetail = getSectionsDetail(pos);

    return GridTile(
      child: Center(
        child: Text(pos.title,
            style: TextStyle(
              color: appColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSizeExtraSmall(context),
            ),
          ),
      ),
      footer: Container(
        padding: EdgeInsets.only(top: screenTab(context)*4),
        child: GridTileBar(
          backgroundColor: appColor,
          title: Text(" "),
          leading: IconButton(
            icon: Icon(Icons.view_agenda_outlined),
            onPressed: () => viewListMode(context, this.widget.idx),
          ),
          trailing: IconButton(
            icon: Icon(Icons.view_list_outlined),
            onPressed: () => viewSplitMode(context, this.widget.idx),
          )
        )
      )
    );
  }
}