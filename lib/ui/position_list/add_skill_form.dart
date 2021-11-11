import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSkillForm extends StatelessWidget {
  const AddSkillForm({
    Key? key,
    required Map<String, String> initValues,
  }) : _initValues = initValues, super(key: key);

  final Map<String, String> _initValues;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                maxLines: 1,
              ),
              TextFormField(
                initialValue: _initValues['place'],
                decoration: InputDecoration(labelText: 'Place'),
                maxLines: 1,
              ),
              TextFormField(
                initialValue: _initValues['city_state'],
                decoration: InputDecoration(labelText: 'City state'),
                maxLines: 1,
              ),
              TextFormField(
                initialValue: _initValues['country'],
                decoration: InputDecoration(labelText: 'Country'),
                maxLines: 1,
              )
            ]
        )
    );
  }
}