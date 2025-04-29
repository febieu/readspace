class BookItem {
  final String title;
  final int edition;
  final String coverId;
  final List<Author> authors;
  final int publishYear;

  BookItem ({
    required this.title,
    required this.edition,
    required this.coverId,
    required this.authors,
    required this.publishYear,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      title: json['title'] ?? "",
      edition: json['edition_count'] ?? 0,
      coverId: json['cover_edition_key'] ?? "",
      authors: json['authors'] != null
          ? List<Author>.from(json['authors'].map((x) => Author.fromJson(x)))
          : <Author>[], // list
      publishYear: json['first_publish_year'] ?? 0,
    );
  }
}

class Author {
  final String key;
  final String name;

  Author ({
    required this.name,
    required this.key,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] ?? "",
      key: json['key'] ?? "",
    );
  }
}