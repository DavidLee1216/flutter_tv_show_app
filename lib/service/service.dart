import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tv_show_app/model/tv_show_model.dart';
import 'package:http/http.dart' as http;

import '../utils/toast.dart';

Map<String, String> requestHeader(String token) {
  if (token != '')
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  else
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
}

Future<TotalTVShows> loadWholePopularShows({int page = 1}) async {
  String api_key = dotenv.env['API_KEY'];
  var url = Uri.parse(
      "https://api.themoviedb.org/3/tv/popular?api_key=$api_key&language=en-US&page=$page");
  final response =
      await http.get(url, headers: requestHeader(dotenv.env['ACCESS_TOKEN']));
  final data = json.decode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    return TotalTVShows.fromMap(data);
  } else {
    showToastMessage(text: data['status_message']);
    return null;
//    showToastMessage(text: 'Can\'t get requested data' , position: 1);
  }
}

Future<TotalTVShows> searchTVShows({int page = 1, String query}) async {
  String api_key = dotenv.env['API_KEY'];
  var url = Uri.parse(
      "https://api.themoviedb.org/3/search/tv?api_key=$api_key&language=en-US&page=$page&query=$query&include_adult=false");
  final response =
      await http.get(url, headers: requestHeader(dotenv.env['ACCESS_TOKEN']));
  final data = json.decode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    return TotalTVShows.fromMap(data);
  } else {
    showToastMessage(text: data['status_message']);
    return null;
  }
}
