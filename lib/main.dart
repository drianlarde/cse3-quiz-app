// Import Flutter Material Design package for UI components.
import 'package:flutter/material.dart';

// Import the MainMenuScreen widget from main_menu_screen.dart.
import 'screens/main_menu_screen.dart';

// The starting point of the app.
void main() {
  // runApp makes MyApp the root of the widget tree and displays it.
  runApp(const MyApp());
}

// MyApp is a StatelessWidget, it doesn't hold mutable state.
class MyApp extends StatelessWidget {
  // Constructor for MyApp, marked as const.
  const MyApp({Key? key}) : super(key: key);

  // build returns the widget tree that constructs the UI.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a top-level container that holds the app's visual structure.
    return MaterialApp(
      // home is set to MainMenuScreen, making it the first screen displayed.
      home: MainMenuScreen(),
    );
  }
}
