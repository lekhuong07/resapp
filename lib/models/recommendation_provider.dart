import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:requests/requests.dart';
import 'package:resapp/models/recommendation.dart';

import 'http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProviderRec with ChangeNotifier {
  Recommendation _profileRecommendation;
  ProviderRec(this._profileRecommendation);

  Recommendation get profileRec{
    return _profileRecommendation;
  }

  List<String> getKeywords(){
    return _profileRecommendation.keywords;
  }

  List<String> getSimilarities(){
    return _profileRecommendation.similarities;
  }

  Future<void> fetchRecommendation(Map<String, String> jobData) async {
    var r = await Requests.put(
        "https://kl-resume-app.herokuapp.com/recommendation/similarity/",
        json: {
          "job_description": jobData['job_description'],
        }
    );
    r.raiseForStatus();
    dynamic responseData = r.json();
    if (responseData['success'] == false){
      throw HttpException(responseData['message']);
    }
    return responseData['message'];
  }
}