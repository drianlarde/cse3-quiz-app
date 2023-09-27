import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categories = {
    '9': 'General Knowledge',
    '12': 'Entertainment: Music',
    // Add more categories here, pwede niyo gamitin yung existing categories sa Open Trivia DB API kaso andaming categories
  };
  final _difficulties = ['easy', 'medium', 'hard'];
  String _selectedCategory = '9';
  String _selectedDifficulty = 'easy';
  int _numberOfQuestions = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSE3 Quiz App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Add a title using const, please use const for all widgets
                  Icon(Icons.quiz, size: 100.0, color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to the CSE3 Quiz App!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please select a category, difficulty, and number of questions to start the quiz.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: _categories.keys
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(_categories[category]!),
                            ))
                        .toList(),
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Difficulty'),
                    items: _difficulties
                        .map((difficulty) => DropdownMenuItem(
                              value: difficulty,
                              child: Text(difficulty[0].toUpperCase() +
                                  difficulty.substring(1)),
                            ))
                        .toList(),
                    value: _selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Number of Questions'),
                    initialValue: '10',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _numberOfQuestions = int.parse(value!);
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Start Quiz'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                category: _selectedCategory,
                                difficulty: _selectedDifficulty,
                                numberOfQuestions: _numberOfQuestions,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Text(
                'Created by Abad, Abelarde, and Dasal',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
