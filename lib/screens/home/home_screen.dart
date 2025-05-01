import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readspace/provider/home/book_list_provider.dart';
import 'package:readspace/screens/detail/detail_screen.dart';
import 'package:readspace/screens/home/carousel_widget.dart';
import 'package:readspace/static/state/book_list_state.dart';

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
      context.read<BookListProvider>().fetchBookList("science");
      context.read<BookListProvider>().fetchBookList("humour");
      context.read<BookListProvider>().fetchBookList("romance");
      context.read<BookListProvider>().fetchBookList("action");
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
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CarouselWidget(),
                const SizedBox(height: 12),

                Consumer<BookListProvider>(
                    builder: (context, value, child) {
                      final stateScience = value.states['science'];
                      final stateHumour = value.states['humour'];
                      final stateRomance = value.states['romance'];
                      final stateAction = value.states['action'];
                      final listScience = value.bookLists['science'];
                      final listHumour = value.bookLists['humour'];
                      final listRomance = value.bookLists['romance'];
                      final listAction = value.bookLists['action'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Section: Science
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.science,
                                size: 24,
                              ),
                              Text(
                                  "Science",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (stateScience is BookListLoadingState)
                            const Center(child: CircularProgressIndicator())
                          else if (stateScience is BookListLoadedState && listScience != null)
                            SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listScience.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: BookCardWidget(
                                        book: listScience[index],
                                        onTap: () {
                                          final selectedBook = listScience[index];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                    bookKey: selectedBook.key,
                                                    bookItem: selectedBook,
                                                ),
                                              )
                                          );
                                        }
                                    ),
                                  );
                                },
                              ),
                            )
                          else if (stateScience is BookListErrorState)
                              Text('Error loading science books'),

                          const SizedBox(height: 16),

                          // Section: Humour
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.tag_faces_rounded,
                                size: 24,
                              ),
                              Text("Humour", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (stateHumour is BookListLoadingState)
                            const Center(child: CircularProgressIndicator())
                          else if (stateHumour is BookListLoadedState && listHumour != null)
                            SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listHumour.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: BookCardWidget(
                                        book: listHumour[index],
                                        onTap: () {
                                          final selectedBook = listHumour[index];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                  bookKey: selectedBook.key,
                                                  bookItem: selectedBook,
                                                ),
                                              )
                                          );
                                        }
                                    ),
                                  );
                                },
                              ),
                            )
                          else if (stateHumour is BookListErrorState)
                              Text('Error loading humour books'),

                          const SizedBox(height: 16),

                          // Section: Romance
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.favorite_sharp,
                                size: 24,
                              ),
                              Text("Romance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (stateRomance is BookListLoadingState)
                            const Center(child: CircularProgressIndicator())
                          else if (stateRomance is BookListLoadedState && listRomance != null)
                            SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listRomance.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: BookCardWidget(
                                        book: listRomance[index],
                                        onTap: () {
                                          final selectedBook = listRomance[index];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                  bookKey: selectedBook.key,
                                                  bookItem: selectedBook,
                                                ),
                                              )
                                          );
                                        }
                                    ),
                                  );
                                },
                              ),
                            )
                          else if (stateRomance is BookListErrorState)
                              Text('Error loading romance books'),

                          const SizedBox(height: 16),
                          // Section: Action
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.whatshot,
                                size: 24,
                              ),
                              Text("Action", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (stateAction is BookListLoadingState)
                            const Center(child: CircularProgressIndicator())
                          else if (stateAction is BookListLoadedState && listAction != null)
                            SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listAction.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: BookCardWidget(
                                        book: listAction[index],
                                        onTap: () {
                                          final selectedBook = listAction[index];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                  bookKey: selectedBook.key,
                                                  bookItem: selectedBook,
                                                ),
                                              )
                                          );
                                        }
                                    ),
                                  );
                                },
                              ),
                            )
                          else if (stateAction is BookListErrorState)
                              Text('Error loading action books'),
                        ],
                      );
                    }
                ),
              ],
            ),
          ),
        ),
    );
  }
}
