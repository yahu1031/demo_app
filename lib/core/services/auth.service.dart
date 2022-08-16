import 'dart:async';
import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';

/// All authentication services for Firebase will be here.
class AuthService {
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;
  AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get the current user
  Future<User?> getUser() async => _auth.currentUser;

  /// Sign in with phone number
  Future<void> authenticateUser(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          UserCredential res = await _auth.signInWithCredential(credential);
          dev.log(res.user.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          dev.log('verificationFailed : ${exception.message}');
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          dev.log('codeSent : $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          dev.log('codeAutoRetrievalTimeout : $verificationId');
        },
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }

  /// Keep listening to user for auth state changes.
  StreamSubscription<User?> listenToUser() =>
      FirebaseAuth.instance.idTokenChanges().listen((User? user) {
        if (user == null) {
          dev.log('User is currently signed out!');
        } else {
          dev.log('User is signed in!');
        }
      });
}
