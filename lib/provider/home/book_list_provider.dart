import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/static/state/restaurant_list_state.dart';

class BookListProvider extends ChangeNotifier {
  final ApiService _apiService;

  BookListProvider(
    this._apiService,
  );

  BookListResultState _resultState = BookListNoneState();

  BookListResultState get resultState => _resultState;

  Future<void> fetchBookList() async {
    try{
      _resultState = BookListLoadingState();
      notifyListeners();
      final result = await _apiService.fetchBookList();

      if (result.works.isEmpty) {
        _resultState = BookListErrorState("No Books Found");
        notifyListeners();
      } else {
        _resultState = BookListLoadedState(result.works);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = BookListErrorState(e.toString());
      notifyListeners();
    }
  }
}








