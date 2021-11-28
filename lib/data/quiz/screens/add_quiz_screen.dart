import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/category/bloc/category_bloc.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_proj/data/quiz/model/quiz_model.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';

class CreateQuizScreen extends StatefulWidget {
  static const routeName = '/newCategory';
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCategoryName = "";
  String _questionText = "";
  String _choiceA = "";
  String _choiceB = "";
  String _choiceC = "";
  String _choiceD = "";

  // String? _selectedAnswer;
  String _selectedAnswer = "A";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizCreateSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(
                  selectedCategory: state.quiz.category,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Create a new quiz question",
                      style: TextStyle(fontSize: 35),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // Text("prompting u"),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter category",
                        labelText: "Category",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _selectedCategoryName = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter question",
                        labelText: "Question",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _questionText = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter choice 1",
                        labelText: "Choice 1",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _choiceA = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter choice 2",
                        labelText: "Choice 2",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _choiceB = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter choice 3",
                        labelText: "Choice 3",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _choiceC = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Enter choice 4",
                        labelText: "Choice 4",
                        // border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        setState(() {
                          print("value ");
                          _choiceD = value ?? "";
                        });
                      },
                      validator: (text) => text == null || text.isEmpty
                          ? "Input can't be empty"
                          : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Set the correct answer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        DropdownButton<String>(
                          // hint: _selectedAnswer == null || _selectedAnswer == ""
                          //     ? Text("Choose")
                          //     : Text(""),
                          hint: Text("$_selectedAnswer"),
                          items:
                              <String>['A', 'B', 'C', 'D'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              // _selectedAnswer = newValue;
                              _selectedAnswer = newValue ?? _selectedAnswer;
                              print("selected answer changed too ");
                            });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _selectedAnswer != null
                          ? () {
                              if (_formKey.currentState!.validate() &&
                                  _selectedAnswer != null) {
                                _formKey.currentState!.save();
                                print("saveddd");
                                print("drop down ");
                                int _indexResultOfAnswer =
                                    _selectedAnswer.codeUnitAt(0) -
                                        "A".codeUnitAt(0);
                                Quiz toBeCreateQuiz = Quiz(
                                  question: _questionText,
                                  answer: _indexResultOfAnswer,
                                  choices: [
                                    _choiceA,
                                    _choiceB,
                                    _choiceC,
                                    _choiceD
                                  ],
                                  category:
                                      Category(name: _selectedCategoryName),
                                );
                                print(
                                    "quiz defined is ${toBeCreateQuiz.category.name}");
                                BlocProvider.of<QuizBloc>(context)
                                    .add(QuizCreate(toBeCreateQuiz));
                                // Navigator.pop(context);
                                // print("name ${toBeCreatedCategory.name}");
                              } else {
                                print("why here");
                              }
                            }
                          : null,
                      child: Text("Create"),
                    ),
                    // BlocBuilder<CategoryBloc, CategoryState>(
                    //   builder: (context, state) {
                    //     return ElevatedButton(
                    //         onPressed: () {
                    //           print("given text .");
                    //           if (_formKey.currentState!.validate()) {
                    //             _formKey.currentState!.save();
                    //             Category toBeCreatedCategory =
                    //                 Category(name: givenText);
                    //             BlocProvider.of<CategoryBloc>(context)
                    //                 .add(CreateQuiz(toBeCreatedCategory));
                    //             Navigator.pop(context);
                    //             print("name ${toBeCreatedCategory.name}");
                    //           } else {
                    //             print("why here");
                    //           }
                    //         },
                    //         child: Text("Submit"));
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
