import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readspace/provider/home/book_list_provider.dart';
import 'package:readspace/static/state/restaurant_list_state.dart';

import 'book_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<BookListProvider>().fetchBookList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'ReadSpace',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<BookListProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              BookListLoadingState() => const Center (
                child: CircularProgressIndicator(),
              ),
              BookListLoadedState(data: var bookList) => SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: BookCardWidget(
                      book: bookList[index],
                      onTap: () {

                        },
                      ),
                    );
                  }
                ),
              ),
              BookListErrorState(error: var message) => Center(
                child: Text(message),
              ),
              _=> const SizedBox(),
            };
          }
        ),
      ),
    );
  }
}
