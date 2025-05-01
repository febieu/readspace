import 'package:readspace/data/model/book_item.dart';

class BookListResponse {
  final int workCount;
  final List<BookItem> works;

  BookListResponse ({
    required this.workCount,
    required this.works,
  });

  factory BookListResponse.fromJson(Map<String, dynamic> json) {
    return BookListResponse(
      workCount: json['workCount'] ?? 0,
      works: json['works'] != null
        ? List<BookItem>.from(json['works'].map((x) => BookItem.fromJson(x)))
        : <BookItem>[],
    );
  }
}