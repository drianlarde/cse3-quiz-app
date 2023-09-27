import 'package:flutter/material.dart';
import '../questions.dart';
import '../main.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;

  ResultScreen({required this.questions});

  @override
  Widget build(BuildContext context) {
    int correctAnswers =
        questions.where((question) => question.isCorrect).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questions[index].question,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Answer: ${questions[index].correctAnswer}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              questions[index].isCorrect
                                  ? Icons.check
                                  : Icons.close,
                              color: questions[index].isCorrect
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              questions[index].isCorrect
                                  ? 'Correct'
                                  : 'Incorrect',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'You got $correctAnswers out of ${questions.length} questions correct.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Go Back to Main Menu'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
