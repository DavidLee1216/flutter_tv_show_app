
//import 'dart:html';
import 'dart:convert';

import 'package:flutter_tv_show_app/model/favorite_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocalStorageHelper {
//  final Storage localStorage = window.localStorage;
//
  Future insert(FavoriteShow fShow) async {
//    String storageData = await localStorage['fShow'];
//    Map<String, dynamic> jsonData =
//        storageData != null ? json.decode(storageData) : null;
//    Map<String, dynamic> new_jsonData = fShow.toMap();
//    if (jsonData != null && jsonData.isNotEmpty) {
//      jsonData['arr'].add(new_jsonData);
//    } else {
//      jsonData = Map<String, dynamic>();
//      jsonData['arr'] = [];
//      jsonData['arr'].add(new_jsonData);
//    }
//    String new_storageData = json.encode(jsonData);
//    localStorage['fShow'] = new_storageData;
  }

  Future<bool> checkId(int id) async {
//    String storageData = await localStorage['fShow'];
//    Map<String, dynamic> jsonData =
//        storageData != null ? json.decode(storageData) : null;
//    if (jsonData == null || jsonData.isEmpty) return false;
//    int idx = findIndex(jsonData['arr'], id);
//    if (idx == -1) return false;
//    return true;
  }

  int findIndex(List<dynamic> arr, int id) {
    for (int i = 0; i < arr.length; i++) {
      if (arr[i]['id'] == id) return i;
    }
    return -1;
  }

  Future<List<FavoriteShow>> getAllFavorites() async {
//    String storageData = await localStorage['fShow'];
//    Map<String, dynamic> jsonData =
//        storageData != null ? json.decode(storageData) : null;
//    if (jsonData == null || jsonData.isEmpty) return [];
//    List<dynamic> arr = jsonData['arr'];
//    List<FavoriteShow> list = arr
//        .map((c) => FavoriteShow(
//        id: c['id'], img_url: c['img_url'], overview: c['overview'], name: c['name']))
//        .toList();
//    return list;
  }

  Future remove(int id) async {
//    String storageData = await localStorage['fShow'];
//    Map<String, dynamic> jsonData =
//        storageData != null ? json.decode(storageData) : null;
//    if (jsonData == null || jsonData.isEmpty) return;
//    int idx = findIndex(jsonData['arr'], id);
//    jsonData['arr'].removeAt(idx);
//    String new_storageData = json.encode(jsonData);
//    localStorage['fShow'] = new_storageData;
  }
}
