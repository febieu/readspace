import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:readspace/provider/detail/detail_book_provider.dart';
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
      context
        .read<DetailBookProvider>()
          .fetchDetailBook(widget.bookKey);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailBookProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            DetailBookLoadingState() =>  Center(
              child: Lottie.asset(
                'assets/animations/loading_spinner.json',
                width: 160,
                height: 160,
              ),
            ),
            DetailBookLoadedState(data: var book) =>
              BodyOfDetailWidget(
                  bookItem: widget.bookItem,
                  detailBook: book,
              ),
            DetailBookErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}