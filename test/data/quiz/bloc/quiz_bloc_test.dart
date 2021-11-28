import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_proj/data/quiz/model/quiz_model.dart';
import 'package:quiz_proj/data/quiz/repository/quiz_repository.dart';

import 'quiz_bloc_test.mocks.dart';

@GenerateMocks([QuizRepository])
void main() {
  late MockQuizRepository mockQuizRepository;
  setUp(() {
    mockQuizRepository = MockQuizRepository();
  });

  group('Test Quiz Repo', () {
    Category currCategory = Category(name: "Animals", id: "1");
    Quiz quiz1 = Quiz(
      category: currCategory,
      choices: ["A", "B", "C", "D"],
      answer: 1,
      question: "Quiz1",
      id: "1001",
    );
    Quiz quiz2 = Quiz(
      category: currCategory,
      choices: ["A", "B", "C", "D"],
      answer: 1,
      question: "Quiz2",
      id: "1002",
    );

    List<Quiz> quizes = [quiz1, quiz2];
    test('Get quizes for specified category', () async {
      when(mockQuizRepository
              .getQuizQuestionsFromGivenCategory(currCategory.name))
          .thenAnswer((_) async => [quiz1, quiz2]);

      var res = await mockQuizRepository
          .getQuizQuestionsFromGivenCategory(currCategory.name);

      expect(res.first.category, currCategory);
    });

    test('Get quizes for specified category 2', () async {
      when(mockQuizRepository
              .getQuizQuestionsFromGivenCategory(currCategory.name))
          .thenAnswer((_) async => [quiz1, quiz2]);

      var res = await mockQuizRepository
          .getQuizQuestionsFromGivenCategory(currCategory.name);

      for (var i = 0; i < res.length; i++) {
        expect(res[i].question, quizes[i].question);
        expect(res[i], quizes[i]); // Using Equatable for object equality
      }
      // expect(res.first, quiz1);
    });
    test('Create quizes for random category', () async {
      Quiz newQuiz = Quiz(
        category: currCategory,
        choices: ["A", "B", "C", "D"],
        answer: 1,
        question: "New Quiz",
        id: "1009",
      );
      when(mockQuizRepository.createQuizQuestionWithGivenCategory(any))
          .thenAnswer((_) async => newQuiz);

      var res =
          await mockQuizRepository.createQuizQuestionWithGivenCategory(newQuiz);

      expect(res, isA<Quiz>());
      expect(res.question, equals(newQuiz.question));
      expect(res, equals(newQuiz));
    });
  });

  group('Quiz Bloc test', () {
    Category currCategory = Category(name: "Animals", id: "1");
    Quiz quiz1 = Quiz(
      category: currCategory,
      choices: ["A", "B", "C", "D"],
      answer: 1,
      question: "Quiz1",
      id: "1001",
    );
    Quiz quiz2 = Quiz(
      category: currCategory,
      choices: ["A", "B", "C", "D"],
      answer: 1,
      question: "Quiz2",
      id: "1002",
    );

    List<Quiz> mockQuizes = [quiz1, quiz2];
    blocTest(
        'emits [QuizLoading(), QuizFailure()] when successfully loading quizes from random category',
        build: () {
          when(mockQuizRepository.getQuizQuestionsFromRandomCategory())
              .thenThrow(QuizFailure());

          return QuizBloc(quizRepository: mockQuizRepository);
        },
        act: (QuizBloc bloc) => bloc.add(LoadRandomQuizes()),
        expect: () => [QuizLoading(), QuizFailure()]);

    blocTest(
        'emits [QuizLoading(), QuizSuccess(quizes)] when successfully loading quizes with specified category',
        build: () {
          when(mockQuizRepository.getQuizQuestionsFromGivenCategory(any))
              .thenAnswer((_) async => mockQuizes);

          return QuizBloc(quizRepository: mockQuizRepository);
        },
        act: (QuizBloc bloc) => bloc.add(LoadQuizesFromGivenCategory(
              categoryName: currCategory.name,
            )),
        expect: () => [QuizLoading(), QuizSuccess(quizes: mockQuizes)]);

    blocTest(
        'emits [QuizLoading(), QuizSuccess(quizes)] when unsuccessfully loading quizes with specified category',
        build: () {
          when(mockQuizRepository.getQuizQuestionsFromGivenCategory(any))
              .thenAnswer((_) async => mockQuizes);

          return QuizBloc(quizRepository: mockQuizRepository);
        },
        act: (QuizBloc bloc) => bloc.add(LoadQuizesFromGivenCategory(
              categoryName: currCategory.name,
            )),
        expect: () => [QuizLoading(), QuizSuccess(quizes: mockQuizes)]);
  });
}
