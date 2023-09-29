// Import necessary Flutter packages.
import 'package:flutter/material.dart';

// Import the http package to fetch questions from an API.
import 'package:http/http.dart' as http;

// Import the dart:convert package to decode the JSON response.
import 'dart:convert';

// Import the Question class and the ResultScreen widget.
import '../questions.dart';
import 'result_screen.dart';

// Define the QuizScreen widget as a StatefulWidget.
class QuizScreen extends StatefulWidget {
  // Define final variables to hold the category, difficulty, and number of questions.
  final String category;
  final String difficulty;
  final int numberOfQuestions;

  // Define a constructor for QuizScreen that initializes the final variables.
  QuizScreen({
    required this.category,
    required this.difficulty,
    required this.numberOfQuestions,
  });

  // Create and return an instance of _QuizScreenState.
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// Define the _QuizScreenState class to manage the state of QuizScreen.
class _QuizScreenState extends State<QuizScreen> {
  // Define a List to hold the questions and an int to track the current question index.
  List<Question> questions = [];
  int currentQuestionIndex = 0;

  // Override the initState method to fetch the questions when the widget is initialized.
  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // Define a method to fetch quiz questions from the Open Trivia Database API.
  fetchQuestions() async {
    // Send a GET request to the API and await the response.
    var res = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=${widget.numberOfQuestions}&category=${widget.category}&difficulty=${widget.difficulty}&type=multiple'));
    // Decode the JSON response.
    var decodedRes = jsonDecode(res.body);
    // Loop through the list of questions in the response and create Question objects.
    List<Question> fetchedQuestions = [];
    for (var questionData in decodedRes['results']) {
      fetchedQuestions.add(Question.fromJson(questionData));
    }
    // Update the state with the fetched questions.
    setState(() {
      questions = fetchedQuestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20), // Move the question upward
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        questions[currentQuestionIndex].question,
                        style: TextStyle(fontSize: 28.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: questions[currentQuestionIndex]
                          .allAnswers
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        String answer = entry.value;
                        Color buttonColor;
                        switch (index) {
                          case 0:
                            buttonColor = Colors.orange;
                            break;
                          case 1:
                            buttonColor = Colors.green;
                            break;
                          case 2:
                            buttonColor = Colors.red;
                            break;
                          case 3:
                            buttonColor = Colors.blue;
                            break;
                          default:
                            buttonColor = Colors.grey;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                answer,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (answer ==
                                    questions[currentQuestionIndex]
                                        .correctAnswer) {
                                  questions[currentQuestionIndex].isCorrect =
                                      true;
                                } else {
                                  questions[currentQuestionIndex].isCorrect =
                                      false;
                                }
                                if (currentQuestionIndex <
                                    questions.length - 1) {
                                  currentQuestionIndex++;
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultScreen(questions: questions),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
