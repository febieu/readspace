import 'book_item.dart';

class SearchResponse {
  final List<BookItem> bookItem;

  SearchResponse ({
    required this.bookItem,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      bookItem: json['docs'] != null
          ? List<BookItem>.from(json['docs']!.map((x) {
        return BookItem.fromJson(x);
      }))
          : <BookItem>[],
    );
  }
}