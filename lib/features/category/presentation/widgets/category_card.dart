// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/core/dialog/app_dialog.dart';
import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/core/helpers/category_icon_helper.dart';

import 'package:doctor_dashboard/features/category/bloc/category_bloc.dart';
import 'package:doctor_dashboard/features/category/bloc/category_event.dart';
import 'package:doctor_dashboard/features/category/data/model/category_model.dart';
import 'package:doctor_dashboard/features/category/presentation/widgets/add_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..translate(0, isHovering ? -4 : 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovering ? 0.09 : 0.05),
              blurRadius: isHovering ? 18 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: isHovering ? const Color(0xFF0B7A75).withOpacity(0.18) : Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF0B7A75).withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(CategoryIconHelper.getIcon(widget.category.icon), color: const Color(0xFF0B7A75), size: 28),
            ),
            const Spacer(),
            Text(
              widget.category.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
            ),
            const SizedBox(height: 6),
            Text(
              CategoryIconHelper.normalizeIconKey(widget.category.icon),
              style: const TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => BlocProvider.value(
                          value: context.read<CategoryBloc>(),
                          child: AddCategoryDialog(category: widget.category),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4B5563),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final confirm = await AppDialog.showDeleteDialog(
                        context: context,
                        title: 'Delete Category',
                        message: 'Are you sure you want to delete this category?',
                      );

                      if (confirm == true && context.mounted) {
                        context.read<CategoryBloc>().add(DeleteCategory(widget.category.id));
                        AppSnackbar.showSuccess(context, 'Category deleted');
                      }
                    },
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
