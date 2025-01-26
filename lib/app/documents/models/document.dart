class Document {
  final String id;
  final String filename;
  final String patientId;
  final String nutritionistId;

  Document({
    required this.id,
    required this.filename,
    required this.patientId,
    required this.nutritionistId,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      filename: json['filename'] as String,
      patientId: json['patientId'] as String,
      nutritionistId: json['nutritionistId'] as String,
    );
  }
}
