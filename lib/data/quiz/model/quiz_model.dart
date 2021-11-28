import 'package:equatable/equatable.dart';
import 'package:quiz_proj/data/category/model/category.dart';

class Quiz extends Equatable {
  List<String> choices;
  String id;
  String question;
  int answer;
  Category category;

  Quiz(
      {required this.choices,
      this.id = "",
      required this.question,
      required this.answer,
      required this.category});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      choices: json['choices'].cast<String>(),
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choices'] = this.choices;
    // data['_id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['category'] = this.category.toJson();
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [choices, id, question, answer, category];
}
