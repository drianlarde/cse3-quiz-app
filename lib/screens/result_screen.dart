// Import necessary Flutter packages.
import 'package:flutter/material.dart';

// Import the Question class and the MyApp widget.
import '../questions.dart';
import '../main.dart';

// Define the ResultScreen widget as a StatelessWidget since it doesn't manage state.
class ResultScreen extends StatelessWidget {
  // Define a final variable to hold the list of questions.
  final List<Question> questions;

  // Define a constructor for ResultScreen that initializes the final variable.
  ResultScreen({required this.questions});

  // Override the build method to construct the UI of the ResultScreen.
  @override
  Widget build(BuildContext context) {
    // Calculate the number of correct answers.
    int correctAnswers =
        questions.where((question) => question.isCorrect).length;

    // Return a Scaffold widget as the visual structure of the ResultScreen.
    return Scaffold(
      // Set up the AppBar with a title.
      appBar: AppBar(
        title: const Text('Results'),
      ),
      // Define the body of the screen to display the quiz results.
      body: Padding(
        // Add padding around the content.
        padding: const EdgeInsets.all(16.0),
        // Arrange the result details in a Column.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use ListView.builder to create a list of result details for each question.
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
