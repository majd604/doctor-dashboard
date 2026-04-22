// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/core/services/cloudinary_service.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_dialog_actions.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_dialog_header.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_form_section.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_image_picker_section.dart';
import 'package:doctor_dashboard/features/doctors/data/models/doctor_model.dart';
import 'package:doctor_dashboard/features/doctors/data/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctorDialog extends StatefulWidget {
  const AddDoctorDialog({super.key, this.doctor});

  final DoctorModel? doctor;

  @override
  State<AddDoctorDialog> createState() => _AddDoctorDialogState();
}

class _AddDoctorDialogState extends State<AddDoctorDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController messagePriceController = TextEditingController();
  final TextEditingController callPriceController = TextEditingController();
  final TextEditingController bookingPriceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  bool isLoading = false;
  Uint8List? selectedImageBytes;
  String? selectedImageName;
  String? selectedSpecialty;
  String? currentImageUrl;

  bool get isEdit => widget.doctor != null;

  @override
  void initState() {
    super.initState();

    if (widget.doctor != null) {
      final doctor = widget.doctor!;
      nameController.text = doctor.name;
      phoneController.text = doctor.phone ?? '';
      ratingController.text = doctor.rating.toString();
      messagePriceController.text = doctor.messagePrice?.toString() ?? '';
      callPriceController.text = doctor.callPrice?.toString() ?? '';
      bookingPriceController.text = doctor.bookingPrice?.toString() ?? '';
      aboutController.text = doctor.about ?? '';
      selectedSpecialty = doctor.specialty;
      currentImageUrl = doctor.imageUrl;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    ratingController.dispose();
    messagePriceController.dispose();
    callPriceController.dispose();
    bookingPriceController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bytes = await picked.readAsBytes();

    setState(() {
      selectedImageBytes = bytes;
      selectedImageName = picked.name;
    });
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedSpecialty == null || selectedSpecialty!.isEmpty) {
      AppSnackbar.showError(context, 'Please select specialty');
      return;
    }

    if (!isEdit && selectedImageBytes == null) {
      AppSnackbar.showError(context, 'Please select an image for the doctor');
      return;
    }

    setState(() => isLoading = true);

    try {
      String imageUrl = currentImageUrl ?? '';

      if (selectedImageBytes != null) {
        imageUrl = await CloudinaryService().uploadImage(selectedImageBytes!);
      }

      final doctor = DoctorModel(
        id: widget.doctor?.id ?? '',
        name: nameController.text.trim(),
        specialty: selectedSpecialty!,
        rating: double.tryParse(ratingController.text.trim()) ?? 0.0,
        imageUrl: imageUrl,
        phone: phoneController.text.trim(),
        messagePrice: double.tryParse(messagePriceController.text.trim()) ?? 0.0,
        callPrice: double.tryParse(callPriceController.text.trim()) ?? 0.0,
        bookingPrice: double.tryParse(bookingPriceController.text.trim()) ?? 0.0,
        about: aboutController.text.trim(),
      );

      if (isEdit) {
        await DoctorService().updateDoctor(widget.doctor!.id, doctor);
      } else {
        await DoctorService().addDoctor(doctor);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(
        context,
        isEdit ? 'Failed to update doctor. Please try again.' : 'Failed to add doctor. Please try again.',
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 24, offset: const Offset(0, 10)),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddDoctorDialogHeader(isEdit: isEdit),
                  const SizedBox(height: 28),
                  AddDoctorImagePickerSection(
                    imageBytes: selectedImageBytes,
                    imageUrl: currentImageUrl,
                    onUploadTap: pickImage,
                    onRemoveTap: () {
                      setState(() {
                        selectedImageBytes = null;
                        selectedImageName = null;
                        currentImageUrl = null;
                      });
                    },
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: formKey,
                    child: AddDoctorFormSection(
                      nameController: nameController,
                      selectedSpecialty: selectedSpecialty,
                      onSpecialtyChanged: (value) {
                        setState(() {
                          selectedSpecialty = value;
                        });
                      },
                      phoneController: phoneController,
                      ratingController: ratingController,
                      messagePriceController: messagePriceController,
                      callPriceController: callPriceController,
                      bookingPriceController: bookingPriceController,
                      aboutController: aboutController,
                    ),
                  ),
                  const SizedBox(height: 26),
                  AddDoctorDialogActions(isLoading: isLoading, onSave: onSave, isEdit: isEdit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
