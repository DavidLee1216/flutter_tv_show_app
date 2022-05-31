import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/tv_show_model.dart';

class TVShowDetailScreen extends StatefulWidget {
  final TVShowModel showModel;

  const TVShowDetailScreen({Key key, this.showModel}) : super(key: key);
  @override
  _TVShowDetailScreenState createState() => _TVShowDetailScreenState();
}

class _TVShowDetailScreenState extends State<TVShowDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Movie Detail',
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            widget.showModel.poster_path != null
                ? Image.network(
                    dotenv.env['IMAGE_BASE_URL'] + widget.showModel.poster_path,
                    height: 360,
                    width: 300,
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.showModel.name,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(width: 10,),
                Text(
                  widget.showModel.first_air_date,
                )
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.showModel.overview,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
