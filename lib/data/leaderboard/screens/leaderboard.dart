import 'package:flutter/material.dart';
import 'package:quiz_proj/data/quiz/screens/quiz_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  static const routeName = '/leaderboard';
  final LeaderBoardArguments args;
  const LeaderboardScreen({Key? key, required LeaderBoardArguments this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You scored",
              style: TextStyle(fontSize: 32, color: Colors.blue),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${args.score}",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 48.0,
                  ),
                ),
                TextSpan(
                  text: "/",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 48.0,
                  ),
                ),
                TextSpan(
                  text: "${args.total}",
                  style: TextStyle(
                    // color: Colors.black87,
                    color: Colors.green,

                    fontSize: 48.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
