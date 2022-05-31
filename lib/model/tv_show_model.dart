class TotalTVShows{
  int page;
  int total_results;
  int total_pages;
  List<TVShowModel> results;
  TotalTVShows({this.page, this.total_results, this.total_pages, this.results});

  factory TotalTVShows.fromMap(Map<String, dynamic> map){
    var list = map['results'] as List;

    List<TVShowModel> modelList = list.map((i)=>TVShowModel.fromMap(i)).toList();
    return TotalTVShows(
      page: map['page'],
      total_results: map['total_results'],
      total_pages: map['total_pages'],
      results: modelList,
    );
  }
}

class TVShowModel{
  String poster_path;
  double popularity;
  int id;
  String backdrop_path;
  double vote_average;
  String overview;
  String first_air_date;
  List<String> origin_country;
  List<int> genre_ids;
  String original_language;
  int vote_count;
  String name;
  String original_name;

  TVShowModel({this.poster_path, this.popularity, this.id, this.backdrop_path, this.vote_average, this.overview, this.first_air_date, this.origin_country, this.genre_ids, this.original_language, this.vote_count, this.name, this.original_name});
  factory TVShowModel.fromMap(Map<String, dynamic> map){
    List<int> _genre_ids = List<int>.from(map['genre_ids'] as List);
    return TVShowModel(
      poster_path: map['poster_path'],
      popularity: map['popularity'],
      id: map['id'],
      backdrop_path: map['backdrop_path'],
      vote_average: map['vote_average'].toDouble(),
      overview: map['overview'],
      first_air_date: map['first_air_date'],
      origin_country: List<String>.from(map['origin_country'] as List),
      genre_ids: _genre_ids,
      original_language: map['original_language'],
      vote_count: map['vote_count'],
      name: map['name'],
      original_name: map['original_name'],
    );
  }
}