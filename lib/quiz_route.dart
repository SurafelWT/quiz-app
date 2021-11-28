import 'package:flutter/material.dart';
import 'package:quiz_proj/data/category/screens/category.dart';
import 'package:quiz_proj/data/category/screens/create_category.dart';
import 'package:quiz_proj/data/leaderboard/screens/leaderboard.dart';
import 'package:quiz_proj/data/quiz/screens/add_quiz_screen.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';
import 'package:quiz_proj/main_screen.dart';

class PageRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          print("here");
          return MainScreen();
        });
      case "/quizs":
        return MaterialPageRoute(builder: (context) {
          // return MyHomePage();
          return QuizScreen();
        });
      case "/categories":
        return MaterialPageRoute(builder: (context) {
          // return MyHomePage();
          return CategoryScreen();
        });
      case "/newCategory":
        return MaterialPageRoute(builder: (context) {
          // return MyHomePage();
          return CreateCategoryScreen();
        });
      case "/newQuiz":
        return MaterialPageRoute(builder: (context) {
          // return MyHomePage();
          return CreateQuizScreen();
        });
      case "/leaderboard":
        return MaterialPageRoute(builder: (context) {
          // return MyHomePage();
          final LeaderBoardArguments args =
              settings.arguments as LeaderBoardArguments;
          return LeaderboardScreen(args: args);
        });
    }
  }
}
