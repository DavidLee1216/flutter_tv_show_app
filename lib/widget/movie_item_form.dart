import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tv_show_app/model/tv_show_model.dart';

class MovieItemForm extends StatefulWidget {
  final TVShowModel showModel;
  MovieItemForm({Key key, this.showModel}) : super(key: key);
  @override
  _MovieItemFormState createState() => _MovieItemFormState();
}

class _MovieItemFormState extends State<MovieItemForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 430,
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                width: 220,
                height: 430,
                child: Column(
                  children: [
                    Image.network(
                      dotenv.env['IMAGE_BASE_URL'] +
                          widget.showModel.poster_path,
                      height: 330,
                      width: 220,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 180,
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
                              Text(
                                widget.showModel.first_air_date,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
//                        Spacer(),
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
