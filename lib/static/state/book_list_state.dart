import 'package:readspace/data/model/book_item.dart';

sealed class BookListResultState {}

class BookListNoneState extends BookListResultState {}

class BookListLoadingState extends BookListResultState {}

class BookListErrorState extends BookListResultState {
  final String error;

  BookListErrorState(this.error);
}

class BookListLoadedState extends BookListResultState {
  final List<BookItem> data;

  BookListLoadedState(this.data);
}