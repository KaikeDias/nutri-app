class Guideline {
  final String id;
  final String title;
  final String content;

  Guideline({required this.id, required this.title, required this.content});

  factory Guideline.fromJson(Map<String, dynamic> json) {
    return Guideline(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
