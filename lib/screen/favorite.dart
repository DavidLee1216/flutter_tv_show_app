import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_show_bloc.dart';
import '../model/favorite_model.dart';
import '../service/db_helper.dart';
import '../service/local_storage.dart';
import '../widget/favorite_item_form.dart';
import '../widget/movie_item_form.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Movies',
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(child: FavoriteListWidget()),
          ],
        ),
      ),
    );
  }
}

class FavoriteListWidget extends StatefulWidget {
  @override
  _FavoriteListWidget createState() => _FavoriteListWidget();
}

class _FavoriteListWidget extends State<FavoriteListWidget > {
  final _scrollController = ScrollController();
  final _scrollThreshold = 20.0;
  List<FavoriteShow> data;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<List<FavoriteShow>> getAllFavorites() async{
    DBHelper dbHelper = DBHelper();
//    await dbHelper.dropTable();
    if(kIsWeb){
      LocalStorageHelper localStorageHelper = LocalStorageHelper();
      data = await localStorageHelper.getAllFavorites();
    } else
    data = await dbHelper.getAllFavorites();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoriteShow>>(
      future: getAllFavorites(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<FavoriteShow>> snapshot) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 440,
                maxCrossAxisExtent: 220,
                childAspectRatio: 1/2,
              ),
              itemCount: data!=null?data.length:0,
              itemBuilder: (BuildContext context, int index) {
                return FavoriteMovieItemForm(
                  showModel: data[index],
                );
              });
        });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }}
