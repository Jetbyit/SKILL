import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';

class AuthService implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email!,
          password: '',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    final User? user = _firebaseAuth.currentUser;
    await user!.reload();
    return user.emailVerified;
  }
}
