import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readspace/provider/home/book_list_provider.dart';
import 'package:readspace/screens/detail/detail_screen.dart';
import 'package:readspace/screens/home/carousel_widget.dart';
import 'package:readspace/screens/home/category_button_widget.dart';
import 'package:readspace/screens/search/search_screen.dart';
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

  String selectedCategory = 'adventure';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<BookListProvider>().fetchBookList("adventure");
      context.read<BookListProvider>().fetchBookList("science");
      context.read<BookListProvider>().fetchBookList("thriller");
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SearchScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.search_outlined,
                color: Colors.purple.shade500,
              ),
          ),
          const SizedBox(width: 12)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CarouselWidget(),
              const SizedBox(height: 12),

              // Category Button
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryButtonWidget(
                      label: 'Adventure',
                      isSelected: selectedCategory == 'adventure',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'adventure';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CategoryButtonWidget(
                      label: 'Romance',
                      isSelected: selectedCategory == 'romance',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'romance';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CategoryButtonWidget(
                      label: 'Action',
                      isSelected: selectedCategory == 'action',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'action';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CategoryButtonWidget(
                      label: 'Thriller',
                      isSelected: selectedCategory == 'thriller',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'thriller';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CategoryButtonWidget(
                      label: 'Science',
                      isSelected: selectedCategory == 'science',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'science';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Consumer
              Consumer<BookListProvider>(
                builder: (context, value, child) {
                  // Fetch state and list based on selected category
                  final state = value.states[selectedCategory];
                  final bookList = value.bookLists[selectedCategory];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show category title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            selectedCategory == 'science' ? Icons.science :
                            selectedCategory == 'thriller' ? Icons.tag_faces_rounded :
                            selectedCategory == 'romance' ? Icons.favorite_sharp :
                            selectedCategory == 'action' ? Icons.whatshot : Icons.category,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            selectedCategory[0].toUpperCase() + selectedCategory.substring(1),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Show loading, error, or book list
                      if (state is BookListLoadingState)
                        Center(
                            child: Lottie.asset('assets/animations/loading.json')
                        )
                      else if (state is BookListLoadedState && bookList != null)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 kolom
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.57, // sesuaikan dengan ukuran card kamu
                          ),
                          itemBuilder: (context, index) {
                            return BookCardWidget(
                              bookItem: bookList[index],
                              onTap: () {
                                final selectedBook = bookList[index];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      bookKey: selectedBook.key,
                                      bookItem: selectedBook,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      else if (state is BookListErrorState)
                          Text('Error loading ${selectedCategory} books'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}