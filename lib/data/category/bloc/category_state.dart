part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategorySuccess extends CategoryState {
  final List<Category> category;

  CategorySuccess(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryCreateSuccess extends CategoryState {
  final Category category;

  CategoryCreateSuccess(this.category);

  @override
  List<Object?> get props => [category];
}

// class CategoryDeleteSuccess extends CategoryState {
//   CategoryDeleteSuccess();

//   @override
//   List<Object?> get props => [];
// }

class CategoryError extends CategoryState {
  final String errorMessage;

  CategoryError(this.errorMessage);

  @override
  List<Object?> get props => [];
}
