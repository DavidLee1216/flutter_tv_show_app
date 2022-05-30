import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Movies',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: HomeListWidget()),
          ],
        ),
      ),
    );
  }
}

class HomeListWidget extends StatefulWidget {
  @override
  _HomeListWidgetState createState() => _HomeListWidgetState();
}

class _HomeListWidgetState extends State<HomeListWidget> {

  QueryCtr _query = new  QueryCtr();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future:
        ListView.builder(itemBuilder: null);
  }
}
