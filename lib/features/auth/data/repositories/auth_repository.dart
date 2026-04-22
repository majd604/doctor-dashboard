import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginAdmin({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user == null) {
      throw Exception('Login failed');
    }
    const adminEmail = 'majdnouful@gmail.com';
    if (user.email != adminEmail) {
      await _firebaseAuth.signOut();
      throw Exception('You are not authorized to access the dashboard');
    }
  }
}
