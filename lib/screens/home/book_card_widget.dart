import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:shimmer/shimmer.dart';

class BookCardWidget extends StatelessWidget {
  final BookItem bookItem;
  final Function() onTap;
  
  BookCardWidget ({
    required this.bookItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 150,
                minHeight: 150,
                maxWidth: 105,
                minWidth: 105,
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
                        width: 105,
                        height: 150,
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
            const SizedBox.square(dimension: 4),
            SizedBox(
              width: 100,
              child: Text(
                bookItem.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
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
          ],
        ),
      ),
    );
  }
}

