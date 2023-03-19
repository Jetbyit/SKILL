import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/services/auth_service.dart';

 class AuthRepository {
  final AuthService _jobAuthervice = AuthService(FirebaseAuth.instance);

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    await _jobAuthervice.signInWithEmailAndPassword(email, password);
  }
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _jobAuthervice.signUpWithEmailAndPassword(email, password);
  }
  Future<void> signOut() async {
    await _jobAuthervice.signOut();
  }
  Future<void> resetPassword(String email) async {
    await _jobAuthervice.resetPassword(email);
  }
  Future<bool> isEmailVerified() async {
    bool isVerified = await _jobAuthervice.isEmailVerified();
    return isVerified;
  }
}
