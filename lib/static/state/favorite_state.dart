import '../../data/model/book_item.dart';

sealed class FavoriteResultState {}

class FavoriteNoneState extends FavoriteResultState {}

class FavoriteLoadingState extends FavoriteResultState {}

class FavoriteErrorState extends FavoriteResultState {
  final String error;
  FavoriteErrorState(this.error);
}

class FavoriteLoadedState extends FavoriteResultState {
  final List<BookItem> data;
  FavoriteLoadedState(this.data);
}