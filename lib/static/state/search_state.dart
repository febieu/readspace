import '../../data/model/book_item.dart';

sealed class SearchResultState {}

class SearchNoneState extends SearchResultState {}

class SearchLoadingState extends SearchResultState {}

class SearchErrorState extends SearchResultState {
  final String error;
  SearchErrorState(this.error);
}

class SearchLoadedState extends SearchResultState {
  final List<BookItem> data;
  SearchLoadedState(this.data);
}