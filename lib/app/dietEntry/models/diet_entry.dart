class DietEntry {
  final String id;
  final String title;
  final List<String> aliments;
  final String photo;
  final String date;

  DietEntry({
    required this.id,
    required this.title,
    required this.aliments,
    required this.photo,
    required this.date,
  });

  factory DietEntry.fromJson(Map<String, dynamic> json) {
    return DietEntry(
      id: json['id'],
      title: json['title'],
      aliments: List<String>.from(json['aliments']),
      photo: json['photo'],
      date: json['date'],
    );
  }
}
