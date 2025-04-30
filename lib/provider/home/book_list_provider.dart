import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/BookItem.dart';
import 'package:readspace/static/state/restaurant_list_state.dart';

class BookListProvider extends ChangeNotifier {
  final ApiService _apiService;

  BookListProvider(
    this._apiService,
  );

  final Map<String, List<BookItem>> _bookLists = {};
  Map<String, List<BookItem>> get bookLists => _bookLists;

  final Map<String, BookListResultState> _states = {};
  Map<String, BookListResultState> get states => _states;

  Future<void> fetchBookList(String subject) async {
    _states[subject] = BookListLoadingState();
    notifyListeners();

    try {
      final result = await _apiService.fetchBookListBasedOnSubject(subject);
      _bookLists[subject] = result.works;
      _states[subject] = BookListLoadedState(result.works);
    } catch (e) {
      _states[subject] = BookListErrorState(e.toString());
    }

    notifyListeners();
  }

  // Future<void> fetchBookList(String subject) async {
  //   try{
  //     _resultState = BookListLoadingState();
  //     notifyListeners();
  //     final result = await _apiService.fetchBookListBasedOnSubject(subject);
  //
  //     if (result.works.isEmpty) {
  //       _resultState = BookListErrorState("No Books Found");
  //       notifyListeners();
  //     } else {
  //       _resultState = BookListLoadedState(result.works);
  //       notifyListeners();
  //     }
  //   } on Exception catch (e) {
  //     _resultState = BookListErrorState(e.toString());
  //     notifyListeners();
  //   }
  // }
}








