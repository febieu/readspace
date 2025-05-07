import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  final ApiService _apiService;
  final List<String> _favoriteKeys = [];
  final List<BookItem> _favoriteBooks = [];

  List<BookItem> get favoriteBooks => _favoriteBooks;
  List<String> get favoriteKeys => _favoriteKeys;

  FavoriteProvider(this._apiService);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteKeys.clear();
    _favoriteKeys.addAll(prefs.getStringList('favorite_books') ?? []);

    _favoriteBooks.clear();
    final encodedBooks = prefs.getStringList('favorite_books_data') ?? [];
    _favoriteBooks.addAll(
      encodedBooks.map((bookStr) => BookItem.fromLocalJson(jsonDecode(bookStr))),
    );

    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_books', _favoriteKeys);
    final encodedBooks = _favoriteBooks.map((book) => jsonEncode(book.toJson())).toList();
    await prefs.setStringList('favorite_books_data', encodedBooks);

    print("Saved books: ${encodedBooks}");

  }

  bool isFavorite(String bookKey) => _favoriteKeys.contains(bookKey);

  Future<void> toggleFavorite(BookItem book) async {
    final key = book.key;

    if (isFavorite(key)) {
      _favoriteKeys.remove(key);
      _favoriteBooks.removeWhere((b) => b.key == key);
    } else {
      _favoriteKeys.add(key);
      _favoriteBooks.add(book);
    }

    await _saveFavorites();
    notifyListeners();
  }
}
