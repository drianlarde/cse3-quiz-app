import 'package:html_unescape/html_unescape.dart';

class Question {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  bool isCorrect = false;

  List<String> get allAnswers =>
      [...incorrectAnswers, correctAnswer]..shuffle();

  Question(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: HtmlUnescape().convert(json['question']),
      correctAnswer: HtmlUnescape().convert(json['correct_answer']),
      incorrectAnswers: List<String>.from(json['incorrect_answers'])
          .map((answer) => HtmlUnescape().convert(answer))
          .toList(),
    );
  }
}
