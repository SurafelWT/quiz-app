import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_proj/data/category/model/category.dart';
import 'package:quiz_proj/data/category/repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetCategories) {
      try {
        yield CategoryLoading();
        List<Category> categories = await categoryRepository.getCategories();
        yield CategorySuccess(categories);
      } catch (e) {
        yield CategoryError("Loading error");
      }
    } else if (event is CreateCategory) {
      try {
        yield CategoryLoading();
        Category createdCategory =
            await categoryRepository.createCategory(event.category);
        yield CategoryCreateSuccess(createdCategory);
      } catch (e) {
        yield CategoryError("creating error");
      }
    } else if (event is DeleteCategory) {
      try {
        yield CategoryLoading();
        await categoryRepository.deleteCategory(event.id);
        List<Category> categories = await categoryRepository.getCategories();
        yield CategorySuccess(categories);
        // yield CategoryDeleteSuccess(categories: categories);
      } catch (e) {
        yield CategoryError("creating error");
      }
    }
  }
}
