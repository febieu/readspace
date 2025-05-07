import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:readspace/data/model/detail_book_response.dart';
import 'package:shimmer/shimmer.dart';


class BodyOfDetailWidget extends StatelessWidget {
  final BookItem bookItem;
  final DetailBookResponse detailBook;
  final bool isFavorite;
  final VoidCallback toggleFavorite;

  const BodyOfDetailWidget ({
    super.key,
    required this.bookItem,
    required this.detailBook,
    required this. isFavorite,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            child: Image.network(
              ApiService.getLargeImage(bookItem.coverId),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 450,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 450,
                    color: Colors.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no-image.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 450,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        bookItem.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: toggleFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isFavorite ? Colors.red : null,
                      ),
                    ),
                  ],
                ),

                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FixedColumnWidth(16),
                    2: IntrinsicColumnWidth(),
                    3: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "Author",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(": "),
                        Text(
                          bookItem.authors.map((a) => a.name).join(', '),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Published Year",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(": "),
                        Text(
                          bookItem.publishYear == 0 ? "N/A" : bookItem.publishYear.toString(),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Edition",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(":"),
                        Text(
                          bookItem.edition.toString(),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(":"),
                        Text(
                          detailBook.subjects.join(', '),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Related People",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(":"),
                        Text(
                          (detailBook.subjectPeople.isNotEmpty)
                              ? detailBook.subjectPeople.join(', ')
                              : "N/A",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Locations ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(":"),
                        Text(
                          (detailBook.subjectPlaces.isNotEmpty)
                              ? detailBook.subjectPlaces.join(', ')
                              : "N/A",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          "Time Periods",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(),
                        Text(":"),
                        Text(
                          (detailBook.subjectTimes.isNotEmpty)
                              ? detailBook.subjectTimes.join(', ')
                              : "N/A",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox.square(dimension: 8),
                Text(
                  "Description:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  (detailBook.description.trim().isEmpty)
                      ? "N/A"
                      : detailBook.description,
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}