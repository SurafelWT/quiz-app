import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_proj/data/category/bloc/category_bloc.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/category/screens/create_category.dart';
import 'package:quiz_proj/data/category/screens/delete_category.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/categories';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async =>
              BlocProvider.of<CategoryBloc>(context).add(GetCategories()),
          child: Column(
            children: [
              Text(
                "Choose a Category",
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                height: 8,
              ),
              Text("(Or long press to delete category)"),
              SizedBox(
                height: 18,
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CategorySuccess) {
                    final List<Category> categoriesList = state.category;
                    return Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                itemCount: categoriesList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return ElevatedButton(
                                      onLongPress: () {
                                        print("deleted");
                                        BlocProvider.of<CategoryBloc>(context)
                                            .add(
                                          DeleteCategory(
                                            categoriesList[index].id,
                                          ),
                                        );
                                      },
                                      onPressed: () {
                                        print(
                                            "clicked ${categoriesList[index].name}");
                                        // Navigator.of(context).pushNamed("/quiz", QuizScreen());
                                        final Category selectedCategory =
                                            categoriesList[index];

                                        // TODO: fetch questions of same category
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuizScreen(
                                                      selectedCategory:
                                                          selectedCategory,
                                                    )));
                                      },
                                      child: Text(categoriesList[index].name));
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, CreateCategoryScreen.routeName);
                              },
                              child: Text("Create new category"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  BlocProvider.of<CategoryBloc>(context).add(GetCategories());
                  return Text("added event");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
