import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 32,
          ),
          Center(
            child: Text(
              "What do you wanna do?",
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
          ),
          Container(
            margin: EdgeInsets.all(32),
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Take a quiz",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/quizs");
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(32),
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Add a question",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/newQuiz");
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(32),
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "View categories",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/categories");
              },
            ),
          ),
        ],
      ),
    );
  }
}
