import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/config/config.dart';

class CategorySource {
  Future<List<Category>> getCategories() async {
    print("before status");
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      final categoriesData = jsonDecode(response.body) as List;
      return categoriesData
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Category> createCategory(Category category) async {
    final response = await http.post(Uri.parse("$baseUrl/categories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(<String, dynamic>{
          "name": category.name,
        }));

    if (response.statusCode == 201) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create category.');
    }
  }

  Future deleteCategory(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/categories/${id}"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
    );

    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      throw Exception('Failed to create category.');
    }
  }

  // not integrated
  // test not added
  Future<Category> updateCategory(Category category) async {
    // Accepts category, id won't change -> finds matching category with existing
    // category id and replaces other properties like name.
    // NOT IMPLEMENTED, FOR TEST
    return Category(name: "A", id: "1");
  }
}
