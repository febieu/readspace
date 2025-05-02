import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readspace/data/model/book_list_response.dart';
import 'package:readspace/data/model/detail_book_response.dart';

class ApiService {
  static const String baseUrl = "https://openlibrary.org/";

  Future<BookListResponse> fetchBookListBasedOnSubject(String subject) async {
    final response = await http.get(
        Uri.parse("$baseUrl/subjects/$subject.json?limit=10"));

    if (response.statusCode == 200) {
      return BookListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch Book List');
    }
  }

  Future<DetailBookResponse> fetchDetailBook(String key) async {
    final response = await http.get(Uri.parse("$baseUrl$key.json"));

    if (response.statusCode == 200) {
      return DetailBookResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch Detail Book');
    }
  }

  static String getMediumImage(coverId) {
    if (coverId == null || coverId.isEmpty) {
      return "";
    } else {
      return "https://covers.openlibrary.org/b/olid/$coverId-M.jpg";
    }
  }

  static String getLargeImage(coverId) {
    if (coverId == null || coverId.isEmpty ) {
      return 'assets/images/no-image.png';
    }
    return "https://covers.openlibrary.org/b/olid/$coverId-L.jpg";
  }
}