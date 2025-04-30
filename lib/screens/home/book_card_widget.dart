import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/BookItem.dart';

class BookCardWidget extends StatelessWidget {
  final BookItem book;
  final Function() onTap;
  
  BookCardWidget ({
    required this.book,
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
                maxWidth: 100,
                minWidth: 100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ApiService.getMediumImage(book.coverId),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/no-image.png'
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
                book.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Text(
              book.publishYear != 0 ? book.publishYear.toString() : "N/A",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}