import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String doctorImageUrl;
  final DateTime date;
  final String time;
  final DateTime createdAt;
  final String? doctorSpecialty;
  final String status; // pending / completed / cancelled
  final String? notes;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.doctorImageUrl,
    required this.date,
    required this.time,
    required this.createdAt,
    this.doctorSpecialty,
    required this.status,
    this.notes,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json, String id) {
    return AppointmentModel(
      id: id,
      userId: json['userId'] ?? '',
      patientName: json['patientName'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorImageUrl: json['doctorImageUrl'] ?? '',
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      time: json['time'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      doctorSpecialty: json['doctorSpecialty'],
      status: (json['status'] ?? 'pending').toString().toLowerCase(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorImageUrl': doctorImageUrl,
      'date': Timestamp.fromDate(date),
      'time': time,
      'createdAt': Timestamp.fromDate(createdAt),
      'doctorSpecialty': doctorSpecialty,
      'status': status.toLowerCase(),
      'notes': notes,
    };
  }

  AppointmentModel copyWith({
    String? patientName,
    String? doctorName,
    String? doctorImageUrl,
    String? doctorSpecialty,
    DateTime? date,
    String? time,
    String? status,
    String? notes,
  }) {
    return AppointmentModel(
      id: id,
      userId: userId,
      patientName: patientName ?? this.patientName,
      doctorId: doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorImageUrl: doctorImageUrl ?? this.doctorImageUrl,
      date: date ?? this.date,
      time: time ?? this.time,
      createdAt: createdAt,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
