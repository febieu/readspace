import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readspace/provider/favorite/favorite_provider.dart';
import 'package:readspace/screens/detail/detail_screen.dart';
import 'package:readspace/screens/search/book_row_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FavoriteProvider>().loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Favorite Books',
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
        padding: const EdgeInsets.all(12),
        child: Consumer<FavoriteProvider>(
          builder: (context, provider, _) {
            final books = provider.favoriteBooks;
            if (books.isEmpty) {
              return Center(child: Text(
                'Add some your favorite books!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ));
            }

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
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
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}



