// Import the html_unescape package to convert HTML escape codes to plain text.
import 'package:html_unescape/html_unescape.dart';

// Define a class named Question to represent a quiz question.
class Question {
  // Define a final String variable to hold the question text.
  final String question;

  // Define a final String variable to hold the correct answer.
  final String correctAnswer;

  // Define a final List of Strings to hold the incorrect answers.
  final List<String> incorrectAnswers;

  // Define a boolean variable to indicate whether the given answer is correct. Initialized to false.
  bool isCorrect = false;

  // Define a getter named allAnswers to get a list of all answers shuffled.
  List<String> get allAnswers =>
      [...incorrectAnswers, correctAnswer]..shuffle();

  // Define a constructor for the Question class, which requires question, correctAnswer, and incorrectAnswers as parameters.
  Question(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  // Define a factory constructor named fromJson to create a Question object from a Map.
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      // Convert the question text from HTML escape codes to plain text.
      question: HtmlUnescape().convert(json['question']),
      // Convert the correct answer from HTML escape codes to plain text.
      correctAnswer: HtmlUnescape().convert(json['correct_answer']),
      // Convert the list of incorrect answers from HTML escape codes to plain text.
      incorrectAnswers: List<String>.from(json['incorrect_answers'])
          .map((answer) => HtmlUnescape().convert(answer))
          .toList(),
    );
  }
}
