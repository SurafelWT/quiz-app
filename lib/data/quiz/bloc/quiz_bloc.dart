import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/quiz/model/quiz_model.dart';
import 'package:quiz_proj/data/quiz/repository/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  QuizBloc({required this.quizRepository}) : super(QuizInitial());

//  Events
  //  QuizCreate
  //  LoadRandomQuizes
  // LoadQuizesFromGivenCategory
  //  UpdateQuiz
  //  DeleteQuiz
// States
  // QuizState
  // QuizInitial
  // QuizSuccess
  // QuizLoading
  // QuizFailure

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadRandomQuizes) {
      yield QuizLoading();
      try {
        final List<Quiz> quizes =
            await quizRepository.getQuizQuestionsFromRandomCategory();
        yield QuizSuccess(quizes: quizes);
      } catch (_) {
        yield QuizFailure();
      }
    } else if (event is LoadQuizesFromGivenCategory) {
      yield QuizLoading();
      try {
        print("ab tot try ${event.categoryName}");
        final List<Quiz> quizes = await quizRepository
            .getQuizQuestionsFromGivenCategory(event.categoryName);
        print("fini");
        yield QuizSuccess(quizes: quizes);
      } on Exception {
        print("in her ewhyyy ");
        yield QuizFailure();
      }
      // catch (_) {
      //   print("in her ewhyyy ");
      //   yield QuizFailure();
      // }
    } else if (event is QuizCreate) {
      yield QuizLoading();
      try {
        print("ab tot try ${event.quiz}");
        final Quiz quiz = await quizRepository
            .createQuizQuestionWithGivenCategory(event.quiz);
        print("fini");
        yield QuizCreateSuccess(quiz: quiz);
      } on Exception {
        print("in her ewhyyy ");
        yield QuizFailure();
      }
      // catch (_) {
      //   print("in her ewhyyy ");
      //   yield QuizFailure();
      // }
    } else {
      print("unknown even ");
      yield QuizFailure();
    }
  }
}
