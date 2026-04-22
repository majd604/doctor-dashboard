import 'package:flutter/material.dart';

class CategoryIconHelper {
  static String normalizeIconKey(String? iconName) {
    final value = (iconName ?? '').toLowerCase().trim();

    switch (value) {
      case 'tooth':
        return 'tooth';

      case 'brain':
      case 'neurology':
        return 'brain';

      case 'bone':
      case 'orthopedic':
      case 'orthopedics':
        return 'bone';

      case 'baby':
      case 'child':
      case 'pediatric':
      case 'pediatrics':
        return 'baby';

      case 'heart':
      case 'cardiology':
        return 'heart';

      case 'eye':
        return 'eye';

      case 'skin':
      case 'dermatology':
        return 'skin';

      default:
        return 'category';
    }
  }

  static IconData getIcon(String? iconName) {
    switch (normalizeIconKey(iconName)) {
      case 'tooth':
        return Icons.medical_services_outlined;
      case 'brain':
        return Icons.psychology_outlined;
      case 'bone':
        return Icons.accessibility_new_rounded;
      case 'baby':
        return Icons.child_care_outlined;
      case 'heart':
        return Icons.favorite_border_rounded;
      case 'eye':
        return Icons.remove_red_eye_outlined;
      case 'skin':
        return Icons.spa_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  static const List<Map<String, String>> availableIcons = [
    {'key': 'tooth', 'label': 'Tooth'},
    {'key': 'brain', 'label': 'Brain'},
    {'key': 'bone', 'label': 'Bone'},
    {'key': 'baby', 'label': 'Baby'},
    {'key': 'heart', 'label': 'Heart'},
    {'key': 'eye', 'label': 'Eye'},
    {'key': 'skin', 'label': 'Skin'},
    {'key': 'category', 'label': 'Category'},
  ];
}
