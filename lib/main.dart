import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';

void main() {
  // Application entry point.
  // Initializes and launches the root widget of the Flutter application.
  runApp(const BookstoreApp());
}

/// Root widget of the bookstore application.
///
/// Defines the global application configuration including theme settings,
/// text direction, and the first screen presented to the user.
class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application display name.
      title: 'کتابکده',

      // Hides the default Flutter debug banner from the application UI.
      debugShowCheckedModeBanner: false,

      // Defines global styling and visual properties shared across the app.
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Applies right-to-left text direction to support Persian language content.
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      // Sets the initial route displayed when the application starts.
      home: const WelcomePage(),
    );
  }
}