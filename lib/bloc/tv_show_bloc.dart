import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_show_app/model/tv_show_model.dart';
import 'package:flutter_tv_show_app/repository/tv_show_repository.dart';

abstract class ShowEvent {}

enum EnumShowEvent { Load, Search }

class ShowLoadEvent extends ShowEvent {
  final int page;
  ShowLoadEvent({this.page = 1});
}

class ShowSearchButtonClickedEvent extends ShowEvent {}

class ShowSearchEvent extends ShowEvent {
  final String searchWord;
  final int page;
  ShowSearchEvent({@required this.searchWord, this.page = 1});
}

class ShowState {
  EnumShowEvent kind;
  String keyword;
  int page;
  List<TVShowModel> showList;
  bool isLoading;

  ShowState(
      {this.kind,
      this.keyword,
      this.showList,
      this.page = 0,
      this.isLoading = false});

  ShowState _setProps(
          {EnumShowEvent kind, List<TVShowModel> showList, bool isLoading}) =>
      ShowState(
          kind: kind ?? this.kind,
          showList: showList ?? this.showList,
          isLoading: isLoading ?? false);

  factory ShowState.init() => ShowState();
  ShowState search(List<TVShowModel> showList) =>
      _setProps(kind: EnumShowEvent.Search, showList: showList);

  bool isSearch() => (kind == EnumShowEvent.Search);

  ShowState submitting() => _setProps(isLoading: true);
}

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  TVShowRepository showRepository;
  ShowBloc({this.showRepository}) : super(ShowState());

  @override
  Stream<ShowState> mapEventToState(ShowEvent event) async* {
    yield state.submitting();
    if (event is ShowLoadEvent) {
      try {
        final stream =
            await showRepository.getTotalShowStream(page: state.page + 1);
        yield ShowState(
            kind: EnumShowEvent.Load,
            showList: stream.results,
            keyword: '',
            page: state.page + 1);
      } catch (e) {
        yield ShowState(kind: EnumShowEvent.Load, showList: []);
      }
    } else if (event is ShowSearchButtonClickedEvent) {
      yield ShowState(page: 0, showList: []);
    } else if (event is ShowSearchEvent) {
      try {
        final stream = await showRepository.getSearchShowStream(
            page: state.page + 1, keyword: event.searchWord);
        yield stream.results.isEmpty
            ? state
            : ShowState(
                kind: EnumShowEvent.Search,
                keyword: event.searchWord,
                showList: state.showList + stream.results,
                page: state.page + 1);
      } catch (e) {
        yield ShowState(
            kind: EnumShowEvent.Search,
            keyword: event.searchWord,
            showList: []);
      }
    }
  }
}
