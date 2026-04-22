import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_dashboard/features/doctors/data/models/doctor_model.dart';

class DoctorService {
  Future<List<DoctorModel>> getDoctors() async {
    final firebase = FirebaseFirestore.instance;
    final snapshot = await firebase.collection('doctors').get();

    return snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<void> addDoctor(DoctorModel doctor) async {
    final firebase = FirebaseFirestore.instance;
    await firebase.collection('doctors').add(doctor.toJson());
  }

  Future<void> deleteDoctor(String id) async {
    final firebase = FirebaseFirestore.instance;
    await firebase.collection('doctors').doc(id).delete();
  }

  Future<void> updateDoctor(String id, DoctorModel doctor) async {
    final firebase = FirebaseFirestore.instance;
    await firebase.collection('doctors').doc(id).update(doctor.toJson());
  }
}
