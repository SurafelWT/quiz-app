import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_proj/data/quiz/model/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';
  final Category selectedCategory;
  QuizScreen({
    Key? key,
    this.selectedCategory = const Category(name: "People"),
    // required this.selectedCategory,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int answeredCount = 0;
  int correctlyAnsweredCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuizBloc>(context).add(LoadQuizesFromGivenCategory(
        categoryName: widget.selectedCategory.name));

    // return SafeArea(child: Center(child: Text("HI")));
  }

  @override
  Widget build(BuildContext context) {
    final String categoryName = widget.selectedCategory.name;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          print("state has ${state.props}");
          // if (state is QuizInitial) {
          //   BlocProvider.of<QuizBloc>(context)
          //       .add(LoadQuizesFromGivenCategory(categoryName: categoryName));

          //   return SafeArea(child: Center(child: Text("HI")));
          // }
          if (state is QuizLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuizSuccess) {
            final List<Quiz> result = state.quizes;
            print("stat hasss ");
            if (result.length == 0) {
              return Center(
                child: Text("No quizes with selected category"),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Category - $categoryName",
                  style: TextStyle(fontSize: 35),
                ),
                Text("answered count $answeredCount"),
                Text("correctly answered count $correctlyAnsweredCount"),
                Expanded(
                  child: ListView.builder(
                      cacheExtent: 122225,
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuizWidget(
                          currentQuiz: result[index],
                          incrementAnswerCount: incrementAnswerCount,
                          incrementCorrectlyAnsweredCount:
                              incrementCorrectlyAnsweredCount,
                        );
                      }),
                ),
                ElevatedButton(
                  // onPressed: () {},
                  onPressed: state.quizes.length == answeredCount
                      ? () {
                          Navigator.of(context).pushNamed(
                            "/leaderboard",
                            arguments: LeaderBoardArguments(
                              score: correctlyAnsweredCount,
                              total: answeredCount,
                            ),
                          );
                        }
                      : null,
                  child: Text("Finish"),
                ),
              ],
            );
          }
          if (state is QuizFailure) {
            return Text("failure");
          }
          // BlocProvider.of<QuizBloc>(context)
          //     .add(LoadQuizesFromGivenCategory(categoryName: categoryName));

          return SafeArea(child: Center(child: Text("HI")));
        },
      ),
    );
  }

  incrementAnswerCount() {
    setState(() {
      answeredCount += 1;
    });
  }

  incrementCorrectlyAnsweredCount() {
    setState(() {
      correctlyAnsweredCount += 1;
    });
  }
}

class LeaderBoardArguments {
  final int score;
  final int total;

  LeaderBoardArguments({
    required this.score,
    required this.total,
  });
}

class QuizWidget extends StatefulWidget {
  final Quiz currentQuiz;
  final Function incrementAnswerCount;
  final Function incrementCorrectlyAnsweredCount;
  const QuizWidget({
    Key? key,
    required this.currentQuiz,
    required this.incrementAnswerCount,
    required this.incrementCorrectlyAnsweredCount,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.currentQuiz.question),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: customButtonStyle(
                index: 0,
                selectedIndex: selectedIndex,
                answer: widget.currentQuiz.answer),
            onPressed: selectedIndex == -1
                ? () {
                    setState(() {
                      selectedIndex = 0;
                      widget.incrementAnswerCount();
                      if (selectedIndex == widget.currentQuiz.answer) {
                        widget.incrementCorrectlyAnsweredCount();
                      }
                    });
                  }
                : null,
            child: MyButton(choices: widget.currentQuiz.choices, index: 0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: customButtonStyle(
                index: 1,
                selectedIndex: selectedIndex,
                answer: widget.currentQuiz.answer),
            onPressed: selectedIndex == -1
                ? () {
                    setState(() {
                      selectedIndex = 1;
                      widget.incrementAnswerCount();
                      if (selectedIndex == widget.currentQuiz.answer) {
                        widget.incrementCorrectlyAnsweredCount();
                      }
                    });
                  }
                : null,
            child: MyButton(choices: widget.currentQuiz.choices, index: 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: customButtonStyle(
                index: 2,
                selectedIndex: selectedIndex,
                answer: widget.currentQuiz.answer),
            onPressed: selectedIndex == -1
                ? () {
                    setState(() {
                      selectedIndex = 2;
                      widget.incrementAnswerCount();
                      if (selectedIndex == widget.currentQuiz.answer) {
                        widget.incrementCorrectlyAnsweredCount();
                      }
                    });
                  }
                : null,
            child: MyButton(choices: widget.currentQuiz.choices, index: 2),
          ),
        ),
        //TODO  change
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: customButtonStyle(
                index: 3,
                selectedIndex: selectedIndex,
                answer: widget.currentQuiz.answer),
            onPressed: selectedIndex == -1
                ? () {
                    setState(() {
                      selectedIndex = 3;
                      widget.incrementAnswerCount();
                      if (selectedIndex == widget.currentQuiz.answer) {
                        widget.incrementCorrectlyAnsweredCount();
                      }
                    });
                  }
                : null,
            child: MyButton(choices: widget.currentQuiz.choices, index: 3),
          ),
        ),
      ],
    );
  }

  ButtonStyle customButtonStyle({
    required int index,
    required int selectedIndex,
    required int answer,
  }) {
    print("selected Index $selectedIndex $answer");
    var isCorrectChoice = false;
    if (selectedIndex != -1) {
      if (selectedIndex == index && selectedIndex == answer) {
        isCorrectChoice = true;
      }

      var isIncorrectChoice = false;
      if (selectedIndex == index && selectedIndex != answer) {
        isIncorrectChoice = true;
      }
      var customBackgroundColor = MaterialStateProperty.all<Color>(Colors.blue);

      if (isCorrectChoice) {
        print("match is found");
        customBackgroundColor = MaterialStateProperty.all<Color>(Colors.green);
      } else {
        print("match not found");
      }
      if (isIncorrectChoice) {
        customBackgroundColor = MaterialStateProperty.all<Color>(Colors.red);
      }
      return ButtonStyle(
        backgroundColor: customBackgroundColor,
      );
    } else {
      print("here");
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      );
    }
  }
}

class MyButton extends StatelessWidget {
  final List<String> choices;
  final int index;
  const MyButton({Key? key, required this.choices, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(choices[index]),
      ],
    );
  }
}
