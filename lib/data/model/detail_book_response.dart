class DetailBookResponse {
  final String title;
  final String description;
  final List<String> subjectPlaces;
  final List<String> subjects;
  final List<String> subjectPeople;
  final List<String> subjectTimes;

  DetailBookResponse ({
    required this.title,
    required this.description,
    required this.subjectPlaces,
    required this.subjects,
    required this.subjectPeople,
    required this.subjectTimes,
  });

  factory DetailBookResponse.fromJson(Map<String, dynamic> json) {
    return DetailBookResponse(
        title: json['title'] ?? "",
        description: json['description'] is String
            ? json['description']
            : (json['description']?['value'] ?? ''),
        subjectPlaces: json['subject_places'] != null
            ? List<String>.from(json['subject_places'])
            : <String>[],
        subjects: json['subjects'] != null
            ? List<String>.from(json['subjects'])
            : <String>[],
        subjectPeople: json['subject_people'] != null
            ? List<String>.from(json['subject_people'])
            : <String>[],
        subjectTimes: json['subject_times'] != null
            ? List<String>.from(json['subject_times'])
            : <String>[],
    );
  }
}