import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readspace/data/model/book_list_response.dart';

class ApiService {
  static const String baseUrl = "https://openlibrary.org/";

  Future<BookListResponse> fetchBookList() async{
    final response = await http.get(Uri.parse("$baseUrl/subjects/funny.json?limit=10"));

    if(response.statusCode == 200){
      return BookListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Book List');
    }
  }

  static String getMediumImage(coverId) {
    return "https://covers.openlibrary.org/b/olid/$coverId-M.jpg";
  }

  static String getLargeImage(coverId) {
    return "https://covers.openlibrary.org/b/olid/$coverId-L.jpg";
  }

}