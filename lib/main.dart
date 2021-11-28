import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/category/bloc/category_bloc.dart';
import 'package:quiz_proj/data/category/repository/category_repository.dart';
import 'package:quiz_proj/data/category/screens/category.dart';
import 'package:quiz_proj/data/category/source/category_source.dart';
import 'package:quiz_proj/data/leaderboard/screens/leaderboard.dart';
import 'package:quiz_proj/data/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_proj/data/quiz/repository/quiz_repository.dart';
import 'package:quiz_proj/quiz_route.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';
import 'package:quiz_proj/data/quiz/source/quiz_source.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(
            CategoryRepository(
              CategorySource(),
            ),
          )..add(GetCategories()),
        ),
        BlocProvider(
          create: (context) => QuizBloc(
            quizRepository: QuizRepository(
              quizSource: QuizSource(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // initialRoute: "/categories",
        // routes: {
        //   // "/quiz": (context) => QuizScreen(selectedCategory: ),
        //   //   // "/leaderboard": (context) => LeaderboardScreen(),
        //   "/categories": (context) => CategoryScreen(),
        // },
        onGenerateRoute: PageRouter.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: CategoryScreen(),
      ),
    );
  }
}
