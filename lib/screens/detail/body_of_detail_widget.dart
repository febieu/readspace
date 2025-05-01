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
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Hero(
              tag: bookItem.coverId,
              child: Image.network(
                ApiService.getLargeImage(bookItem.coverId),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookItem.title,
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
                        bookItem.authors.map((a) => a.name).join(', '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
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
                        detailBook.subjects.join(', '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
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
                        detailBook.subjectPeople.join(', '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
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
                        detailBook.subjectPlaces.join(', '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
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
                        detailBook.subjectTimes.join(', '),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox.square(dimension: 4),
                Text(
                    "Description:"
                ),
                Text(
                  detailBook.description,
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