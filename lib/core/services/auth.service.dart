import 'dart:async';
import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';

/// All authentication services for Firebase will be here.
class AuthService {
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;
  AuthService._();

  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Get the current user
  User? get getUser => auth.currentUser;

  String get name => getUser?.displayName ?? 'Your name';

  /// Sign in with phone number
  Future<String?> getOtp(
    String phone, {
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    try {
      String? vCode;
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          dev.log(credential.token.toString());
        },
        verificationFailed: (FirebaseAuthException exception) {
          dev.log('verificationFailed : ${exception.message}');
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          vCode = verificationId;
          dev.log('codeSent : $verificationId');
          dev.log('forceResendingToken : $forceResendingToken');
          codeSent.call(verificationId, forceResendingToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          dev.log('codeAutoRetrievalTimeout : $verificationId');
        },
      );
      return vCode;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Verify the OTP
  Future<UserCredential?> verifyOtp(String vCode, String otp) async {
    try {
      UserCredential credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: vCode, smsCode: otp));
      dev.log(credential.user.toString());
      return credential;
    } catch (e) {
      dev.log(e.toString());
      return null;
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
