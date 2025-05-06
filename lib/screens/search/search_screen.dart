import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readspace/provider/search/search_provider.dart';
import 'package:readspace/screens/detail/detail_screen.dart';
import 'package:readspace/screens/search/book_row_item.dart';
import 'package:readspace/static/state/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchProvider>().fetchSearchBook(value);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SearchProvider>().fetchSearchBook("Harry Potter");
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Discover Books",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple.shade200,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      _onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Looking for a book?",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(44.0),
                        borderSide: const BorderSide(
                          color: Colors.purpleAccent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(44.0),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: Colors.purple,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {

                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size(2, 2),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Search book result
            Expanded(
                child: Consumer<SearchProvider> (
                  builder: (context, value, child) {
                    return switch (value.resultState) {
                      SearchNoneState() => Center(
                          child: Text("There is no result can be found"),
                      ),
                      SearchLoadingState() => Center(
                          child: Lottie.asset(
                            'assets/animations/loading_spinner.json',
                            width: 160,
                            height: 160,
                          ),
                      ),
                      SearchErrorState() => Center(
                        child: Text("Error to show result from Search Book"),
                      ),
                      SearchLoadedState(data: var books) => ListView.builder(
                        itemCount: books.length,
                        itemBuilder:(context, index) {
                          final book = books[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: BookRowItem(
                                bookItem: book,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => DetailScreen(
                                        bookKey: book.key,
                                        bookItem: book,
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      ),
                    };
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}