import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tv_show_app/model/favorite_model.dart';
import 'package:flutter_tv_show_app/model/tv_show_model.dart';
import 'package:flutter_tv_show_app/service/db_helper.dart';

class FavoriteMovieItemForm extends StatefulWidget {
  final FavoriteShow showModel;
  FavoriteMovieItemForm({Key key, this.showModel}) : super(key: key);
  @override
  _FavoriteMovieItemFormState createState() => _FavoriteMovieItemFormState();
}

class _FavoriteMovieItemFormState extends State<FavoriteMovieItemForm> {
  bool isFavorite = false;

//  Future<void> pressFavorite() async{
//    isFavorite = !isFavorite;
//    DBHelper dbHelper = DBHelper();
//    if(isFavorite) {
//      FavoriteShow show = FavoriteShow(id: widget.showModel.id, img_url: widget.showModel.img_url, overview: widget.showModel.overview, name: widget.showModel.name);
//      await dbHelper.insertData(show);
//    } else{
//      await dbHelper.deleteData(widget.showModel.id);
//    }
//    setState(() {});
//  }
//
//  Future<bool> checkFavorite() async{
//    DBHelper dbHelper = DBHelper();
////    await dbHelper.dropTable();
//    if(await dbHelper.getData(widget.showModel.id) != null)
//      isFavorite = true;
//    return isFavorite;
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 440,
//        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    width: 220,
                    height: 440,
                    child: Column(
                      children: [
                        widget.showModel.img_url != null ? Image.network(
                          dotenv.env['IMAGE_BASE_URL'] +
                              widget.showModel.img_url,
                          height: 330,
                          width: 220,
                        ):Container(),
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
                                    widget.showModel.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: ()=>{},
                              icon: Icon(Icons.favorite),
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
        );
  }
}
