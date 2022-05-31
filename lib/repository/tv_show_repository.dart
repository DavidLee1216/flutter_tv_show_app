import 'package:flutter_tv_show_app/model/tv_show_model.dart';
import 'package:flutter_tv_show_app/service/service.dart' as service;

class TVShowRepository {
  Future<TotalTVShows> getTotalShowStream({int page = 1}) async {
    return service.loadWholePopularShows(page: page);
  }

  Future<TotalTVShows> getSearchShowStream(
      {int page = 1, String keyword}) async {
    return service.searchTVShows(page: page, query: keyword);
  }
}
