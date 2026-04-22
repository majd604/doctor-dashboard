// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_dashboard/features/appointment/data/model/appointment_model.dart';

class AppointmentService {
  Future<List<AppointmentModel>> getAllAppointments() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('appointments').orderBy('createdAt', descending: true).get();

      return snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  Future<void> updateAppointmentStatus(String appointmentId, String newStatus) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('appointments').doc(appointmentId).update({'status': newStatus});
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('appointments').doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  Future<void> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTime,
  }) async {
    try {
      final firebase = FirebaseFirestore.instance;
      await firebase.collection('appointments').doc(appointmentId).update({
        'date': Timestamp.fromDate(newDate),
        'time': newTime,
      });
    } catch (e) {
      throw Exception('Failed to reschedule appointment: $e');
    }
  }
}
