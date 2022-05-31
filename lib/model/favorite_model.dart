class FavoriteShow{
  int id;
  String img_url;
  String overview;
  String name;
  FavoriteShow({this.id, this.img_url, this.overview, this.name});

  factory FavoriteShow.fromMap(Map<String, dynamic> map){
    return FavoriteShow(
      id: map['id'],
      img_url: map['img_url'],
      overview: map['overview'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'img_url': img_url,
      'overview': overview,
      'name': name,
    };
  }

}