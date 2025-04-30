import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> imageAssets = [
    'assets/images/carousel-1.png',
    'assets/images/carousel-2.png',
    'assets/images/carousel-3.png',
    'assets/images/carousel-4.png',
    'assets/images/carousel-5.png',
  ];

  CarouselWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageAssets.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(url, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        enableInfiniteScroll: true,
      ),
    );
  }
}