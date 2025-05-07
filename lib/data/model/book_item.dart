class BookItem {
  final String title;
  final String key;
  final String coverId;
  final int edition;
  final int publishYear;
  final List<Author> authors;
  final List<String> categories;
  final Availability availability;

  BookItem ({
    required this.title,
    required this.key,
    required this.edition,
    required this.coverId,
    required this.authors,
    required this.publishYear,
    required this.categories,
    required this.availability,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'coverId': coverId,
      'edition': edition,
      'publishYear': publishYear,
      'authors': authors.map((author) => author.toJson()).toList(),
      'categories': categories,
      'availability': availability.toJson(),
    };
  }

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      title: json['title'] ?? "",
      key: json['key'] ?? "",
      coverId: json['cover_edition_key'] ?? "",
      edition: json['edition_count'] ?? 0,
      publishYear: json['first_publish_year'] ?? 0,
      authors: json['authors'] != null
          ? List<Author>.from(json['authors'].map((x) => Author.fromJson(x)))
          : <Author>[], // list
      categories: json['subject'] != null
          ? List<String>.from(json['subject'])
          : <String>[],
      availability: Availability.fromJson(json['availability'] ?? {}), // list
    );
  }

  factory BookItem.fromLocalJson(Map<String, dynamic> json) {
    return BookItem(
      title: json['title'] ?? "",
      key: json['key'] ?? "",
      coverId: json['coverId'] ?? "",
      // Ambil coverId dari SharedPreferences
      edition: json['edition'] ?? 0,
      publishYear: json['publishYear'] ?? 0,
      authors: json['authors'] != null
          ? List<Author>.from(json['authors'].map((x) => Author.fromJson(x)))
          : <Author>[],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : <String>[],
      availability: Availability.fromJson(json['availability'] ?? {}),
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

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
    };
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] ?? "",
      key: json['key'] ?? "",
    );
  }
}

class Availability {
  final String isbn;
  final bool statusToBorrow;
  final bool statusToRead;

  Availability ({
    required this.isbn,
    required this.statusToBorrow,
    required this.statusToRead,
});

  Map<String, dynamic> toJson() {
    return {
      'isbn': isbn,
      'available_to_borrow': statusToBorrow,
      'is_readable': statusToRead,
    };
  }

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      isbn: json['isbn'] ?? "",
      statusToBorrow: json['available_to_borrow'] ?? false,
      statusToRead: json['is_readable'] ?? false,
    );
  }
}