import 'package:doctor_dashboard/features/category/bloc/category_bloc.dart';
import 'package:doctor_dashboard/features/category/bloc/category_state.dart';
import 'package:doctor_dashboard/features/category/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryError) {
          return Center(child: Text(state.message));
        }

        if (state is CategoryLoaded && state.categories.isEmpty) {
          return const Center(
            child: Text(
              'No categories found',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
            ),
          );
        }

        if (state is CategoryLoaded) {
          final categories = state.categories;

          return GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1.18,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(category: category);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
