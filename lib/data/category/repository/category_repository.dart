import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/category/source/category_source.dart';

class CategoryRepository {
  final CategorySource categorySource;

  CategoryRepository(this.categorySource);
  Future<List<Category>> getCategories() async {
    print("reached here");
    return await categorySource.getCategories();
  }

  Future<Category> createCategory(Category category) async {
    print("reached creating category");
    return await categorySource.createCategory(category);
  }

  Future deleteCategory(String id) async {
    print("reached deleting category");
    return await categorySource.deleteCategory(id);
  }

  // not integrated,
  // test added
  Future<Category> updateCategory(Category category) async {
    // Accepts category, id won't change -> finds matching category with existing
    // category id and replaces other properties like name.
    return await categorySource.updateCategory(category);
  }
}
