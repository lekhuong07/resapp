import 'package:flutter/cupertino.dart';

class  Recommendation with ChangeNotifier {
  List<String> similarities;
  List<String> keywords;

  Recommendation({
    required this.similarities,
    required this.keywords,
  });
}