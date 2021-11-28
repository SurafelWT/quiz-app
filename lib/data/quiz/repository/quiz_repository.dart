import 'dart:convert';

import 'package:quiz_proj/data/quiz/model/quiz_model.dart';
import 'package:quiz_proj/data/quiz/source/quiz_source.dart';

class QuizRepository {
  final QuizSource quizSource;

  QuizRepository({required this.quizSource});

  Future<List<Quiz>> getQuizQuestionsFromRandomCategory() async {
    return await quizSource.getQuizQuestionsFromRandomCategory();
  }

  Future<List<Quiz>> getQuizQuestionsFromGivenCategory(
      String categoryName) async {
    print("inside repo");
    return await quizSource.getQuizQuestionsFromGivenCategory(categoryName);
  }

  // Future<Quiz> createQuizWithProvidedCategory(
  //     Quiz quiz, String categoryName) async {
  //   final res =
  //       await quizSource.createQuizWithProvidedCategory(quiz, categoryName);
  //   return res;
  // }

  Future<Quiz> createQuizQuestionWithGivenCategory(Quiz quiz) async {
    return await quizSource.createQuizWithGivenCategory(quiz);
  }

  Future<List<Quiz>> getAllQuizQuestions() async {
    return await quizSource.getAllQuizQuestions();
  }
}
