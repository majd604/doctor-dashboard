import 'package:doctor_dashboard/features/category/data/model/category_model.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel category;

  AddCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateCategory extends CategoryEvent {
  final String id;
  final CategoryModel category;

  UpdateCategory({required this.id, required this.category});

  @override
  List<Object?> get props => [id, category];
}

class DeleteCategory extends CategoryEvent {
  final String id;

  DeleteCategory(this.id);

  @override
  List<Object?> get props => [id];
}
