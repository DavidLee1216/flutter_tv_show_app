import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: null);
  }
}
