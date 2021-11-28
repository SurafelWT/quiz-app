part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizCreate extends QuizEvent {
  final Quiz quiz;

  const QuizCreate(this.quiz);

  @override
  List<Object> get props => [quiz];
}

class LoadRandomQuizes extends QuizEvent {
  const LoadRandomQuizes();
  @override
  List<Object> get props => [];
}

class LoadQuizesFromGivenCategory extends QuizEvent {
  final String categoryName;
  const LoadQuizesFromGivenCategory({required this.categoryName});
  @override
  List<Object> get props => [categoryName];
}

class UpdateQuiz extends QuizEvent {
  final Quiz quiz;
  const UpdateQuiz(this.quiz);
  @override
  List<Object> get props => [];
}

class DeleteQuiz extends QuizEvent {
  final Quiz quiz;
  const DeleteQuiz(this.quiz);

  @override
  List<Object> get props => [];
}
