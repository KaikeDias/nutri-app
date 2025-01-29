class Question {
  String id;
  String question;
  String answer;
  
  Question({
    required this.id,
    required this.question,
    this.answer = "",
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
