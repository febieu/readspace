import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:readspace/provider/detail/detail_book_provider.dart';
import 'package:readspace/provider/favorite/favorite_provider.dart';
import 'package:readspace/screens/detail/body_of_detail_widget.dart';
import 'package:readspace/static/state/detail_book_state.dart';

class DetailScreen extends StatefulWidget {
  final String bookKey;
  final BookItem bookItem;

  const DetailScreen ({
    super.key,
    required this.bookKey,
    required this.bookItem,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState(){
    super.initState();

    Future.microtask(() {
      context.read<DetailBookProvider>().fetchDetailBook(widget.bookKey);
      context.read<FavoriteProvider>().loadFavorites();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<DetailBookProvider, FavoriteProvider>(
        builder: (context, detailProvider, favoriteProvider, _) {
          final state = detailProvider.resultState;

          return switch (state) {
            DetailBookLoadingState() => Center(child: CircularProgressIndicator()),
            DetailBookLoadedState(data: var book) => BodyOfDetailWidget(
              bookItem: widget.bookItem,
              detailBook: book,
              isFavorite: favoriteProvider.isFavorite(widget.bookItem.key),
              toggleFavorite: () {
                favoriteProvider.toggleFavorite(widget.bookItem);
              },
            ),
            DetailBookErrorState(error: var msg) => Center(child: Text(msg)),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

//Consumer<DetailBookProvider>(
//         builder: (context, value, child) {
//           return switch (value.resultState) {
//             DetailBookLoadingState() =>  Center(
//               child: Lottie.asset(
//                 'assets/animations/loading_spinner.json',
//                 width: 160,
//                 height: 160,
//               ),
//             ),
//             DetailBookLoadedState(data: var book) =>
//               BodyOfDetailWidget(
//                 bookItem: widget.bookItem,
//                 detailBook: book,
//                 isFavorite: value.isFavorite(widget.bookItem.key),
//                 toggleFavorite: () {
//                   value.toggleFavorite(widget.bookItem.key);
//                 },
//               ),
//             DetailBookErrorState(error: var message) => Center(
//               child: Text(message),
//             ),
//             _ => const SizedBox(),
//           };
//         },
//       ),