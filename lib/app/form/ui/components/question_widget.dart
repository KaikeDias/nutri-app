import 'package:flutter/material.dart';
import 'package:nutri_app/app/form/models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Se houver uma resposta já salva, defina-a no controlador
    _answerController.text = widget.question.answer;
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                hintText: 'Sua resposta',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Atualiza a resposta
                setState(() {
                  widget.question.answer = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
