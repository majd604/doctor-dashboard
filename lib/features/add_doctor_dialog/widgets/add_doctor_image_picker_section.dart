import 'dart:typed_data';
import 'package:flutter/material.dart';

class AddDoctorImagePickerSection extends StatelessWidget {
  const AddDoctorImagePickerSection({
    super.key,
    required this.imageBytes,
    required this.onUploadTap,
    required this.onRemoveTap,
    required this.imageUrl,
  });

  final Uint8List? imageBytes;
  final VoidCallback onUploadTap;
  final VoidCallback onRemoveTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageBytes != null) {
      imageWidget = Image.memory(imageBytes!, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => const Icon(Icons.person_rounded, size: 52, color: Color(0xFF9CA3AF)),
      );
    } else {
      imageWidget = const Icon(Icons.person_rounded, size: 52, color: Color(0xFF9CA3AF));
    }

    return Row(
      children: [
        Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              colors: [Color(0xFF0B7A75), Color(0xFF139A94)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(color: Colors.white, child: imageWidget),
          ),
        ),
        const SizedBox(width: 22),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Doctor Photo',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload a professional photo for the doctor profile.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: onUploadTap,
                    icon: const Icon(Icons.upload_rounded, size: 18),
                    label: const Text('Upload'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B7A75),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: (imageBytes == null && (imageUrl == null || imageUrl!.isEmpty)) ? null : onRemoveTap,
                    icon: const Icon(Icons.delete_outline_rounded, size: 18),
                    label: const Text('Remove'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6B7280),
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
