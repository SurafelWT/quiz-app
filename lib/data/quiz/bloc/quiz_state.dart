part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {
  @override
  List<Object> get props => [];
}

class QuizSuccess extends QuizState {
  final List<Quiz> quizes;

  QuizSuccess({required this.quizes});

  @override
  List<Object> get props => [quizes];
}

class QuizLoading extends QuizState {}

class QuizFailure extends QuizState {}

class QuizCreateSuccess extends QuizState {
  final Quiz quiz; //TODO: do we need this??

  QuizCreateSuccess({required this.quiz});

  @override
  List<Object> get props => [quiz];
}
