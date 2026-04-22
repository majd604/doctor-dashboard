// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/core/helpers/category_icon_helper.dart';
import 'package:doctor_dashboard/features/category/bloc/category_bloc.dart';
import 'package:doctor_dashboard/features/category/bloc/category_event.dart';
import 'package:doctor_dashboard/features/category/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key, this.category});

  final CategoryModel? category;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedIcon;
  bool isLoading = false;

  bool get isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category!.name;
      selectedIcon = CategoryIconHelper.normalizeIconKey(widget.category!.icon);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void onSave() {
    if (!formKey.currentState!.validate()) return;

    if (selectedIcon == null || selectedIcon!.isEmpty) {
      AppSnackbar.showError(context, 'Please select an icon');
      return;
    }

    final category = CategoryModel(
      id: widget.category?.id ?? '',
      name: nameController.text.trim(),
      icon: selectedIcon!,
    );

    if (isEdit) {
      context.read<CategoryBloc>().add(UpdateCategory(id: widget.category!.id, category: category));
      AppSnackbar.showSuccess(context, 'Category updated successfully');
    } else {
      context.read<CategoryBloc>().add(AddCategory(category));
      AppSnackbar.showSuccess(context, 'Category added successfully');
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 24, offset: const Offset(0, 10)),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCategoryDialogHeader(isEdit: isEdit),
                    const SizedBox(height: 26),
                    AddCategoryNameField(controller: nameController),
                    const SizedBox(height: 20),
                    AddCategoryIconDropdown(
                      value: selectedIcon,
                      onChanged: (value) {
                        setState(() {
                          selectedIcon = value;
                        });
                      },
                    ),
                    const SizedBox(height: 28),
                    AddCategoryDialogActions(isEdit: isEdit, onSave: onSave),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddCategoryDialogHeader extends StatelessWidget {
  const AddCategoryDialogHeader({super.key, required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(color: const Color(0xFFE8F7F6), borderRadius: BorderRadius.circular(18)),
          child: const Icon(Icons.category_outlined, color: Color(0xFF0B7A75), size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? 'Edit Category' : 'Add New Category',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 6),
              Text(
                isEdit ? 'Update category name and icon.' : 'Add a new doctor specialty category.',
                style: const TextStyle(fontSize: 14.5, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddCategoryNameField extends StatelessWidget {
  const AddCategoryNameField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category Name',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter category name';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Enter category name',
            prefixIcon: const Icon(Icons.badge_outlined, color: Color(0xFF0B7A75)),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF0B7A75), width: 1.3),
            ),
          ),
        ),
      ],
    );
  }
}

class AddCategoryIconDropdown extends StatelessWidget {
  const AddCategoryIconDropdown({super.key, required this.value, required this.onChanged});

  final String? value;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category Icon',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: CategoryIconHelper.availableIcons.map((item) {
            return DropdownMenuItem<String>(
              value: item['key'],
              child: Row(
                children: [
                  Icon(CategoryIconHelper.getIcon(item['key']!), color: const Color(0xFF0B7A75), size: 20),
                  const SizedBox(width: 10),
                  Text(item['label']!),
                ],
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            prefixIcon: const Icon(Icons.image_outlined, color: Color(0xFF0B7A75)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF0B7A75), width: 1.3),
            ),
          ),
        ),
      ],
    );
  }
}

class AddCategoryDialogActions extends StatelessWidget {
  const AddCategoryDialogActions({super.key, required this.isEdit, required this.onSave});

  final bool isEdit;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6B7280),
              side: BorderSide(color: Colors.grey.shade300),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: Icon(isEdit ? Icons.edit_outlined : Icons.save_outlined, size: 20),
            label: Text(
              isEdit ? 'Update Category' : 'Save Category',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B7A75),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
        ),
      ],
    );
  }
}
