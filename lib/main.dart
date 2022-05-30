import 'package:flutter/material.dart';
import 'package:flutter_tv_show_app/screen/favorite.dart';
import 'package:flutter_tv_show_app/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV show app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TV show home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
//  bool _initState = true;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 30.0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home
              ),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_rounded
              ),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
//              _initState = false;
            });
          }),
    );
  }
}
