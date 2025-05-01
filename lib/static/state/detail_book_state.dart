import 'package:readspace/data/model/detail_book_response.dart';

sealed class DetailBookResultState {}

class DetailBookNoneState extends DetailBookResultState {}

class DetailBookLoadingState extends DetailBookResultState {}

class DetailBookErrorState extends DetailBookResultState {
  final String error;
  DetailBookErrorState(this.error);
}

class DetailBookLoadedState extends DetailBookResultState {
  final DetailBookResponse data;
  DetailBookLoadedState(this.data);
}