import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;

  const Category({this.id = "", required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
