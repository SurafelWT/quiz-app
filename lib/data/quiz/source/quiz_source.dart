import 'package:http/http.dart' as http;
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/category/source/category_source.dart';
import 'package:quiz_proj/data/config/config.dart';
import 'package:quiz_proj/data/quiz/model/quiz_model.dart';
import 'dart:convert';

class QuizSource {
  QuizSource();

  Future<List<Quiz>> getQuizQuestionsFromRandomCategory() async {
    final response = await http.get(Uri.parse("uri"));

    if (response.statusCode == 200) {
      final quizes = jsonDecode(response.body) as List;
      return quizes.map((quiz) => Quiz.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to get random quizes.');
    }
  }

  Future<List<Quiz>> getQuizQuestionsFromGivenCategory(
      String categoryName) async {
    // categoryName = "animals"; //TODO change category

    print("I'm apple1");
    final response = await http
        .get(Uri.parse("$baseUrl/quizs?categoryname=${categoryName}"));
    print("I'm apple2");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> quizesData = jsonDecode(response.body) as List;
      final List<Quiz> res =
          quizesData.map((quiz) => Quiz.fromJson(quiz)).toList();
      return res;
    } else {
      throw Exception('Failed to get quizes from category $categoryName.');
    }
  }

  // Future<Quiz> createQuizWithProvidedCategory(
  //     Quiz quiz, String categoryName) async {
  //   final response = await http.post(
  //     Uri.http(baseUrl, '/quizs'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       'question': quiz.question,
  //       'choices': quiz.choices,
  //       'answer': quiz.answer,
  //     }),
  //   );

  //   // if (response.statusCode == 200) {
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     // return response.body;
  //     return quiz;
  //   } else {
  //     throw Exception('Failed to get quizes from category $categoryName.');
  //   }
  // }

  Future<Quiz> createQuizWithGivenCategory(Quiz quiz) async {
    CategorySource categorySource = CategorySource();
    List<Category> allCategories = await categorySource.getCategories();
    late Category requiredCategory;
    // requiredCategory = Category(name: quiz.category.name); //TODO remove this
    for (var currCategory in allCategories) {
      if (currCategory.name == quiz.category.name) {
        requiredCategory = currCategory;
      }
    }
    // if (requiredCategory == null) {
    //   requiredCategory = await categorySource.createCategory(quiz.category);
    // }
    quiz.category = requiredCategory;
    print(
        "fetched category is ${quiz.category.name} with id ${quiz.category.id}.!");

    final response = await http.post(
      // Uri.http(baseUrl, '/quizs'),
      Uri.parse("$baseUrl/quizs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'question': quiz.question,
        'choices': quiz.choices,
        'answer': quiz.answer,
        'category': quiz.category.toJson(),
      }),
    );

    print("soooo status code is ${response.statusCode}");
    // if (response.statusCode == 200) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // return response.body;
      return quiz;
    } else {
      throw Exception(
          'Failed to get quizes from category ${quiz.category.name}.');
    }
  }

  Future<List<Quiz>> getAllQuizQuestions() async {
    final response = await http.get(Uri.parse("$baseUrl/quizs/allQuizes"));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> quizesData = jsonDecode(response.body) as List;
      final List<Quiz> res =
          quizesData.map((quiz) => Quiz.fromJson(quiz)).toList();
      return res;
    } else {
      throw Exception('Failed to get all quizes .');
    }
  }
}
