import 'package:flutter/material.dart';
import 'package:resapp/models/position.dart';
import 'package:provider/provider.dart';
import 'package:resapp/models/position_provider.dart';
import 'package:resapp/ui/position_list/position_editor.dart';

import '../constants.dart';

class PositionListView extends StatefulWidget {
  const PositionListView({
    Key? key,
  }) : super(key: key);

  @override
  State<PositionListView> createState() => _PositionListViewState();
}

class _PositionListViewState extends State<PositionListView> {
  @override
  Widget build(BuildContext context) {
    void selectPosition (BuildContext ctx, int index){
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return PositionEditor();
          },
          settings: RouteSettings(
            arguments: index,
          ),
        ),
      );
    }

    final productData = Provider.of<ProviderPositions>(context);
    final products = productData.items;
    return ListView.separated(
      padding: EdgeInsets.only(left: screenTab(context), right: screenTab(context)),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
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
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
