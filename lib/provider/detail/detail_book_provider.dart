import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/static/state/detail_book_state.dart';

class DetailBookProvider extends ChangeNotifier {
  final ApiService _apiService;

  DetailBookProvider (
      this._apiService,
  );

  DetailBookResultState _resultState = DetailBookNoneState();
  DetailBookResultState get resultState => _resultState;

  Future<void> fetchDetailBook(String key) async {
    _resultState = DetailBookLoadingState();
    notifyListeners();
    try{
      final result = await _apiService.fetchDetailBook(key);
      _resultState = DetailBookLoadedState(result);
      notifyListeners();
    } catch (e) {
      _resultState = DetailBookErrorState("Gagal fetch");
      notifyListeners();
    }
  }
}