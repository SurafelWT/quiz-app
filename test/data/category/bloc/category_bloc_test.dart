import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_proj/data/category/bloc/category_bloc.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/category/repository/category_repository.dart';

import 'category_bloc_test.mocks.dart';

@GenerateMocks([CategoryRepository])
void main() {
  late MockCategoryRepository mockCategoryRepository;
  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
  });

  group('Test Category Repo', () {
    Category mockCategory1 = Category(name: "Animals");
    Category mockCategory2 = Category(name: "Food");
    List<Category> mockCategories = [mockCategory1, mockCategory2];
    // List<Category> incorrectCategories = [mockCategory1];

    test('(GET) Find all quiz categories', () async {
      when(mockCategoryRepository.getCategories())
          .thenAnswer((_) async => mockCategories);

      var res = await mockCategoryRepository.getCategories();
      expect(res, equals(mockCategories));
    });

    test('(CREATE) Add a quiz category', () async {
      Category newCategory = Category(name: "NEW", id: "1001");
      // Category incorrectNewCategory = Category(name: "OLD", id: "100");
      when(mockCategoryRepository.createCategory(newCategory))
          .thenAnswer((_) async => newCategory);

      var res = await mockCategoryRepository.createCategory(newCategory);
      expect(res, equals(newCategory)); // Using Equatable for Category
    });

    test('(DELETE) Delete a quiz category', () async {
      Category existingCategory = Category(name: "NEW", id: "1001");
      // Category incorrectexistingCategory = Category(name: "OLD", id: "100");
      when(mockCategoryRepository.deleteCategory(any))
          .thenAnswer((_) async => null);

      var res =
          await mockCategoryRepository.deleteCategory(existingCategory.id);
      expect(res, null);
    });

    test('(UPDATE) update a quiz category', () async {
      Category currentCategory = Category(name: "CURRENT", id: "1001");
      Category modifiedCategory =
          Category(name: "category2", id: "1001"); // name is changed
      when(mockCategoryRepository.updateCategory(currentCategory))
          .thenAnswer((_) async => modifiedCategory);

      var res = await mockCategoryRepository.updateCategory(currentCategory);
      // expect(res.name, equals("category3"));
      expect(res.name, equals("category2"));
    });
  });

  group('Category Bloc test', () {
    Category mockCategory1 = Category(name: "Animals");
    Category mockCategory2 = Category(name: "Food");
    List<Category> mockCategories = [mockCategory1, mockCategory2];
    // List<Category> incorrectCategories = [mockCategory1];

    blocTest(
        'emits [CategoryLoading(), CategorySuccess(mockCategories)] when successful * getCategories',
        build: () {
          when(mockCategoryRepository.getCategories())
              .thenAnswer((_) async => mockCategories);

          return CategoryBloc(mockCategoryRepository);
        },
        act: (CategoryBloc categoryBloc) => categoryBloc.add(GetCategories()),
        expect: () => [CategoryLoading(), CategorySuccess(mockCategories)]);

    blocTest(
        'emits [CategoryLoading(), CategoryError(creating error)] when not successful * getCategories',
        build: () {
          when(mockCategoryRepository.getCategories()).thenThrow(CategoryError);

          return CategoryBloc(mockCategoryRepository);
        },
        act: (CategoryBloc categoryBloc) => categoryBloc.add(GetCategories()),
        expect: () => [CategoryLoading(), CategoryError('creating error')]);
    // expect: () => [CategoryLoading(), CategorySuccess(mockCategories)]);
  });
}
