import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/static/state/search_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService _apiService;

  SearchProvider(
      this._apiService,
  );

  SearchResultState _resultState = SearchNoneState();

  SearchResultState get resultState => _resultState;

  Future<void> fetchSearchBook (String query) async {
    _resultState = SearchLoadingState();
    notifyListeners();

    if (query.trim().isEmpty) {
      _resultState = SearchNoneState();
      notifyListeners();
      return;
    }

    try {
      final result = await _apiService.fetchSearchBook(query);
      _resultState = SearchLoadedState(result.bookItem);
      notifyListeners();

    } catch (e) {
      _resultState = SearchErrorState("Failed to search data");
      notifyListeners();
    }
  }

}