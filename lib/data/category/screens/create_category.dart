import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/category/bloc/category_bloc.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';

class CreateCategoryScreen extends StatefulWidget {
  static const routeName = '/newCategory';
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  String givenText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoryError) {
            return Text("Error creating category");
          }
          if (state is CategoryCreateSuccess) {
            return Text(
                "Sucesss is here category with name ${state.category.name} is created id is -> ${state.category.id}");
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Choose a Category",
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  // Text("prompting u"),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Enter category (name)",
                      // border: InputBorder.none,
                    ),
                    onSaved: (value) {
                      setState(() {
                        print("value ");
                        givenText = value ?? "";
                      });
                    },
                    validator: (text) => text == null || text.isEmpty
                        ? "Input can't be empty"
                        : null,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("given text $givenText .");
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Category toBeCreatedCategory =
                              Category(name: givenText);
                          BlocProvider.of<CategoryBloc>(context)
                              .add(CreateCategory(toBeCreatedCategory));
                          // Navigator.pop(context);
                          print("name ${toBeCreatedCategory.name}");
                        } else {
                          print("why here");
                        }
                      },
                      child: Text("Submit")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
