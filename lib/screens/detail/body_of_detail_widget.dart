import 'package:flutter/cupertino.dart';
import 'package:readspace/data/api/api_service.dart';
import 'package:readspace/data/model/book_item.dart';
import 'package:readspace/data/model/detail_book_response.dart';


class BodyOfDetailWidget extends StatelessWidget {
  final BookItem bookItem;
  final DetailBookResponse detailBook;
  final List<Author> author;
  final Availability availability;


  const BodyOfDetailWidget ({
    super.key,
    required this.bookItem,
    required this.detailBook,
    required this.author,
    required this.availability,
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
            child: Hero(
              tag: bookItem.coverId,
              child: Image.network(
                ApiService.getLargeImage(bookItem.coverId),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 450,
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
          ),

          // Title
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookItem.title ?? "N/A",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Author",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(width: 74,),
                    Text(":"),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                      child: Text(
                        bookItem.authors.map((a) => a.name).join(', ') ?? "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                // Published Year
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Published Year"
                    ),
                    const SizedBox(width: 16),
                    Text(":"),
                    const SizedBox(width: 4),
                    Text(
                      bookItem.publishYear == 0 ? "N/A" : bookItem.publishYear.toString(),
                    ),
                  ],
                ),
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Edition"
                    ),
                    const SizedBox(width: 73),
                    Text(":"),
                    const SizedBox(width: 4),
                    Text(
                      bookItem.edition.toString(),
                    ),
                  ],
                ),

                // Category
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Category"
                    ),
                    const SizedBox(width: 59),
                    Text(":"),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        detailBook.subjects.join(', ') ?? "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                // Related People
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Related People"
                    ),
                    const SizedBox(width: 17),
                    Text(":"),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        (detailBook.subjectPeople.isNotEmpty ?? false)
                            ? detailBook.subjectPeople.join(', ')
                            : "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                // Locations
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Locations "
                    ),
                    const SizedBox(width: 50),
                    Text(":"),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        (detailBook.subjectPlaces.isNotEmpty ?? false)
                            ? detailBook.subjectPlaces.join(', ')
                            : "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                // Time Periods
                const SizedBox.square(dimension: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Time Periods"
                    ),
                    const SizedBox(width: 30),
                    Text(":"),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        (detailBook.subjectTimes.isNotEmpty ?? false)
                            ? detailBook.subjectTimes.join(', ')
                            : "N/A",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                // Description
                const SizedBox.square(dimension: 4),
                Text(
                    "Description:"
                ),
                Text(
                  (detailBook.description.trim().isEmpty)
                      ? "N/A"
                      : detailBook.description,
                ),
                const SizedBox.square(dimension: 4),
                const SizedBox.square(dimension: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}