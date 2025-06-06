import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/navigation/navigation.dart';
import 'package:readspace/provider/detail/detail_book_provider.dart';
import 'package:readspace/provider/favorite/favorite_provider.dart';
import 'package:readspace/provider/home/book_list_provider.dart';
import 'package:readspace/provider/search/search_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookListProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailBookProvider(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
            context.read<ApiService>(),
          )
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(
              context.read<ApiService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadScape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade400),
        useMaterial3: true,
      ),
      home: Navigation(),
    );
  }
}
