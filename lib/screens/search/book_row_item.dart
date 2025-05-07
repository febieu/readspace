import 'package:flutter/material.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:shimmer/shimmer.dart';

class BookRowItem extends StatelessWidget {
  final BookItem bookItem;
  final VoidCallback onTap;

  BookRowItem ({
    required this.bookItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 135,
                    minHeight: 120,
                    maxWidth: 100,
                    minWidth: 100,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      ApiService.getMediumImage(bookItem.coverId),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100,
                            height: 120,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no-image.png',
                          fit: BoxFit.cover,
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookItem.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                      Text(
                        bookItem.authors.isNotEmpty
                            ? bookItem.authors.map((author) => author.name).join(", ")
                            : "-",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        bookItem.publishYear != 0 ? bookItem.publishYear.toString() : "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Borrowable: ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            bookItem.availability.statusToBorrow ? Icons.check : Icons.cancel,
                            color: bookItem.availability.statusToBorrow ? Colors.purple.shade400 : Colors.grey,
                            size: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(height: 4,),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }
}