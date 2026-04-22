import 'package:doctor_dashboard/core/constants/add_doctor_specialty_dropdown.dart';
import 'package:doctor_dashboard/core/constants/app_constants.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_text_area.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/widgets/add_doctor_text_field.dart';
import 'package:flutter/material.dart';

class AddDoctorFormSection extends StatelessWidget {
  const AddDoctorFormSection({
    super.key,
    required this.nameController,

    required this.phoneController,
    required this.ratingController,
    required this.messagePriceController,
    required this.callPriceController,
    required this.bookingPriceController,
    required this.aboutController,
    required this.selectedSpecialty,
    required this.onSpecialtyChanged,
  });
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController ratingController;
  final TextEditingController messagePriceController;
  final TextEditingController callPriceController;
  final TextEditingController bookingPriceController;
  final TextEditingController aboutController;
  final String? selectedSpecialty;
  final Function(String?) onSpecialtyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.name,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter doctor name';
                  }
                  return null;
                },
                controller: nameController,
                label: 'Doctor Name',
                hintText: 'Enter full doctor name',
                icon: Icons.person_outline_rounded,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddDoctorSpecialtyDropdown(
                    value: selectedSpecialty,
                    items: AppConstants.specialties,
                    onChanged: onSpecialtyChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.phone,

                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                controller: phoneController,
                label: 'Phone Number',
                hintText: 'Enter phone number',
                icon: Icons.phone_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter rating';
                  }
                  return null;
                },
                controller: ratingController,
                label: 'Rating',
                hintText: 'Enter rating',
                icon: Icons.star_border_rounded,
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter message price';
                  }
                  return null;
                },
                controller: messagePriceController,
                label: 'Message Price',
                hintText: 'Enter message price',
                icon: Icons.message_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter booking price';
                  }
                  return null;
                },
                controller: bookingPriceController,

                label: 'Booking Price',
                hintText: 'Enter booking price',
                icon: Icons.calendar_month_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AddDoctorTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter call price';
                  }
                  return null;
                },
                controller: callPriceController,
                label: 'Call Price',
                hintText: 'Enter call price',
                icon: Icons.call_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        AddDoctorTextArea(
          keyboardType: TextInputType.text,
          controller: aboutController,
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Please enter about doctor';
            }
            return null;
          },
          label: 'About Doctor',
          hintText: 'Write a short professional bio about the doctor...',
          icon: Icons.description_outlined,
        ),
      ],
    );
  }
}
