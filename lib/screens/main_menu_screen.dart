// Import the necessary packages for building UI and navigating between screens.
import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'style_utils.dart';

// Define MainMenuScreen as a StatefulWidget since it will manage local state.
class MainMenuScreen extends StatefulWidget {
  // Create and return an instance of _MainMenuScreenState.
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

// Define the state class _MainMenuScreenState.
class _MainMenuScreenState extends State<MainMenuScreen> {
  // Define a key to uniquely identify the Form widget for validation.
  final _formKey = GlobalKey<FormState>();

  // Define available quiz categories and their IDs.
  final _categories = {
    '9': 'General Knowledge',
    '12': 'Entertainment: Music',
    // More categories can be added here.
  };

  // Define available quiz difficulties.
  final _difficulties = ['easy', 'medium', 'hard'];

  // Initialize the selected category, difficulty, and number of questions.
  String _selectedCategory = '9';
  String _selectedDifficulty = 'easy';
  int _numberOfQuestions = 10;

  // Define the build method to construct the UI.
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget as the visual scaffold for the screen.
    return Scaffold(
      // Set up the AppBar with a title.
      appBar: AppBar(
        title: const Text('CSE3 Quiz App'),
      ),
      // Define the body of the screen as a Form widget.
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            // Add padding around the form content.
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            // Arrange form elements in a Column.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Add a title using const, please use const for all widgets
                    Image.asset(
                      'images/quiz-app-logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    // seems redundant
                    // const Text(
                    //   'Welcome to the CSE3 Quiz App!',
                    //   style: TextStyle(
                    //     fontSize: 24.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    const SizedBox(height: 30),
                    const Text(
                      'Select your preferred category, level, and number of questions.',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration:
                      dropdownStyle.copyWith(label: const Text('Category')),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: dropdownStyle.copyWith(
                          label: const Text('Difficulty')),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
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
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: dropdownStyle.copyWith(
                          label: const Text('Number of questions')),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBD553),
                        ),
                        child: const Text(
                          'Start Quiz',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16.0,),
                        ),
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
                // const SizedBox(height: double.infinity),
                const Text(
                  'Created by Abad, Abelarde, and Dasal',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
