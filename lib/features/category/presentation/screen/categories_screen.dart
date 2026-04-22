// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/category/bloc/category_bloc.dart';
import 'package:doctor_dashboard/features/category/bloc/category_event.dart';
import 'package:doctor_dashboard/features/category/data/services/category_service.dart';
import 'package:doctor_dashboard/features/category/presentation/widgets/categories_header.dart';
import 'package:doctor_dashboard/features/category/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(categoryService: CategoryService())..add(LoadCategories()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CategoriesHeader(),
              SizedBox(height: 24),
              Expanded(child: CategoriesList()),
            ],
          ),
        ),
      ),
    );
  }
}
