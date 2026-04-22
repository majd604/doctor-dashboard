import 'package:doctor_dashboard/features/appointment/presentation/screens/appointments_screen.dart';
import 'package:doctor_dashboard/features/category/presentation/screen/categories_screen.dart';
import 'package:doctor_dashboard/features/dashboard/presentation/widgets/dashboard_menu_card.dart';
import 'package:doctor_dashboard/features/doctors/screens/doctors_screen.dart';
import 'package:doctor_dashboard/features/message/presentation/screens/messages_screen.dart';
import 'package:flutter/material.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.2,
      children: [
        DashboardMenuCard(
          title: "Doctors",
          subtitle: "Manage doctors list",
          icon: Icons.medical_services_outlined,
          color: const Color(0xFF0B7A75),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorsScreen()));
          },
        ),
        DashboardMenuCard(
          title: "Appointments",
          subtitle: "Manage bookings",
          icon: Icons.calendar_month_outlined,
          color: const Color(0xFF6366F1),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentsScreen()));
          },
        ),
        DashboardMenuCard(
          title: "Messages",
          subtitle: "Patient conversations",
          icon: Icons.message_outlined,
          color: const Color(0xFFF59E0B),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MessagesScreen()));
          },
        ),
        DashboardMenuCard(
          title: "Categories",
          subtitle: "Doctor specialties",
          icon: Icons.category_outlined,
          color: const Color(0xFFEF4444),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen()));
          },
        ),
      ],
    );
  }
}
