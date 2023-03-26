import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserData extends ChangeNotifier {
  User? user;
  String? currentUserId;
}
