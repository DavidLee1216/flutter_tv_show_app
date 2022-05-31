import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_show_bloc.dart';
import '../widget/movie_item_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowBloc>(context).add(ShowLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Movies',
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ShowBloc, ShowState>(
        cubit: BlocProvider.of<ShowBloc>(context),
        builder:(context, state) {
          return SafeArea(child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SearchBarWidget(),
                    Divider(
                      height: 3,
                      color: Colors.black54,
                    ),
                    Expanded(child: ShowListWidget()),
                  ],
                ),
              )
            ],
          ));
        }
      )
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  final _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var keywordBox = Container(
        height: 40,
        child: TextField(
          controller: _keywordController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Enter search word',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffcccccc)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xcccccccc)),
            ),
          ),
        ));

    var searchButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 5,
      height: 40,
      buttonColor: Colors.blueAccent,
      child: ElevatedButton(
        child: Text('Search',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: Colors.white,
            )),
        onPressed: () {
          BlocProvider.of<ShowBloc>(context)
              .add(ShowSearchButtonClickedEvent());
          if (_keywordController.text == '')
            BlocProvider.of<ShowBloc>(context).add(
                ShowLoadEvent());
          else
            BlocProvider.of<ShowBloc>(context).add(
                ShowSearchEvent(searchWord: _keywordController.text));
        },
      ),
    );

    return Column(children: [
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 10,
          ),
          Expanded(child: keywordBox),
          SizedBox(
            width: 10,
          ),
          searchButton,
        ]),
      ),
      SizedBox(height: 20),
    ]);
  }
}

class ShowListWidget extends StatefulWidget {
  @override
  _ShowListWidgetState createState() => _ShowListWidgetState();
}

class _ShowListWidgetState extends State<ShowListWidget> {
  final _scrollController = ScrollController();

  final _scrollThreshold = 20.0;


  int maxPage = 1;
  EnumShowEvent kind = EnumShowEvent.Load;
  String searchWord = '';

  ShowBloc bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    bloc = BlocProvider.of<ShowBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowBloc, ShowState>(
      cubit: BlocProvider.of<ShowBloc>(context),
      builder: (BuildContext context, state) {
        if (state is ShowState) {
          kind = state.kind;
          searchWord = state.keyword;
          maxPage = state.page;
          if (state.showList != null && state.showList.isEmpty) {
            return Center(
              child: Text(
                'Nothing to show',
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return MovieItemForm(
                showModel: state.showList[index],
              );
            },
            itemCount: state.showList != null ? state.showList.length : 0,
            controller: _scrollController,
          );
        }
        return Container();
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll > 5 &&
        maxScroll - currentScroll <= _scrollThreshold &&
        bloc != null) {
      if (kind == EnumShowEvent.Load)
        bloc.add(
            ShowLoadEvent(page: maxPage + 1));
      else
        bloc.add(ShowSearchEvent(
            searchWord: searchWord, page: maxPage + 1));
      Future.delayed(Duration(milliseconds: 200), () {});
    }
  }
}
