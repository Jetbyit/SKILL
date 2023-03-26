import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_portal/src/data/models/usermodel.dart';
import 'package:job_portal/src/data/repositories/auth_repository.dart';

class AuthService implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService(this._firebaseAuth);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
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
  Future<String?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // retrieve the user ID from Firebase Authentication
      final User? user = _auth.currentUser;
      final String userId = user!.uid;

      // return the user ID
      return userId!;

      ///await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String?> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
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

  @override
  Future<void> saveUserType(String? userId, bool? isWorker) async {
    try {
      await _firestore.collection('type').doc(userId).set(
        {
          'type': isWorker,
        },
      );
    } catch (e) {
      print("err when try to add saveUserType information is : ${e}");
    }
  }

  @override
  Future<bool?> getUserType(String? userId) async {
    bool? userType;
    try {
      DocumentSnapshot doc = await _firestore.collection('type').doc(userId).get();
      userType = doc['type'];//doc.data()?['type'];
    } catch (e) {
      print("err when try to get getUserType information is : ${e}");
    }
    return userType;
  }
}
