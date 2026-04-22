import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_dashboard/features/category/data/model/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();

      return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _firestore.collection('categories').add(category.toJson());
    } catch (e) {
      throw Exception('Failed to add category');
    }
  }

  Future<void> updateCategory(String id, CategoryModel category) async {
    try {
      await _firestore.collection('categories').doc(id).update(category.toJson());
    } catch (e) {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete category');
    }
  }
}
