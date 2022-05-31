import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tv_show_app/model/favorite_model.dart';
import 'package:flutter_tv_show_app/model/tv_show_model.dart';
import 'package:flutter_tv_show_app/screen/tv_show_detail.dart';
import 'package:flutter_tv_show_app/service/db_helper.dart';
import 'package:flutter_tv_show_app/service/local_storage.dart';
import 'package:flutter_tv_show_app/utils/navigation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TVShowDetailArguments {
  final TVShowModel showModel;
  TVShowDetailArguments({this.showModel});
}

class MovieItemForm extends StatefulWidget {
  final TVShowModel showModel;
  MovieItemForm({Key key, this.showModel}) : super(key: key);
  @override
  _MovieItemFormState createState() => _MovieItemFormState();
}

class _MovieItemFormState extends State<MovieItemForm> {
  bool isFavorite = false;

  Future<void> pressFavorite() async {
    isFavorite = !isFavorite;
    DBHelper dbHelper = DBHelper();
    if (isFavorite) {
      FavoriteShow show = FavoriteShow(
          id: widget.showModel.id,
          img_url: widget.showModel.poster_path,
          overview: widget.showModel.overview,
          name: widget.showModel.name);
      if (kIsWeb) {
        LocalStorageHelper localStorageHelper = LocalStorageHelper();
        localStorageHelper.insert(show);
      } else
        await dbHelper.insertData(show);
    } else {
      if (kIsWeb) {
        LocalStorageHelper localStorageHelper = LocalStorageHelper();
        localStorageHelper.remove(widget.showModel.id);
      } else
        await dbHelper.deleteData(widget.showModel.id);
    }
    setState(() {});
  }

  Future<bool> checkFavorite() async {
    DBHelper dbHelper = DBHelper();
//    await dbHelper.dropTable();
    if(kIsWeb){
      LocalStorageHelper localStorageHelper = LocalStorageHelper();
      if(await localStorageHelper.checkId(widget.showModel.id))
        isFavorite = true;
      else
        isFavorite = false;
    }
    else if (await dbHelper.getData(widget.showModel.id) != null) isFavorite = true;
    return isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 440,
//        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: FutureBuilder<bool>(
          future: checkFavorite(),
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return InkWell(
                onTap: () {
//                  Navigator.pushNamed(context, '/detail',
//                      arguments: TVShowDetailArguments(showModel: widget.showModel));
                  pushTo(
                      context, TVShowDetailScreen(showModel: widget.showModel));
                },
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        width: 220,
                        height: 440,
                        child: Column(
                          children: [
                            widget.showModel.poster_path != null
                                ? Image.network(
                                    dotenv.env['IMAGE_BASE_URL'] +
                                        widget.showModel.poster_path,
                                    height: 330,
                                    width: 220,
                                  )
                                : Container(),
                            Row(
                              children: [
                                Container(
                                  height: 110,
                                  width: 150,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.showModel.name??"",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        widget.showModel.first_air_date??"",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
//                        Spacer(),
                                IconButton(
                                  onPressed: pressFavorite,
                                  icon: isFavorite
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border_outlined),
                                  color: Colors.red,
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ));
          },
        ));
  }
}
