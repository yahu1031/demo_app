import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInProvider() {
    _isSigningIn = false;
  }
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isSigningIn = false;
  late String mUsertoken;

  // Get uid
  String getCurrentUid() => _firebaseAuth.currentUser!.uid;

  // Get current Users
  String getCurrentUser() => _firebaseAuth.currentUser!.displayName.toString();

  // Get current User id Token
  void getUserToken() =>
      _firebaseAuth.currentUser!.getIdToken().then((String value) => value);
  // User? tokenResult = await _firebaseAuth.currentUser;
  // String idToken = await tokenResult!.getIdToken();
  // return await idToken.toString();
  // }

// Get current Users
  String getCurrentUserEmail() => _firebaseAuth.currentUser!.email.toString();

  // Get image url
  Object getUserImage() {
    if (_firebaseAuth.currentUser!.photoURL != null) {
      return NetworkImage(
        _firebaseAuth.currentUser!.photoURL.toString(),
      );
    } else {
      return const Icon(Icons.account_circle_outlined);
    }
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future<void> tokenLogin(String idToken) async {
    try {
      await _firebaseAuth
          .signInWithCustomToken(idToken)
          .then(
            (UserCredential value) {},
          )
          .onError((dynamic error, StackTrace stackTrace) {
        throw error.toString();
      });
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<void> login() async {
  //   isSigningIn = true;
  //   try {
  //     GoogleSignInAccount? user = await googleSignIn
  //         .signIn()
  //         .onError((dynamic signinError, StackTrace stackTrace) {
  //       throw signinError.toString();
  //     }).catchError((dynamic onSigninError) {
  //       throw onSigninError.toString();
  //     });
  //     if (user == null) {
  //       isSigningIn = false;
  //       return;
  //     } else {
  //       GoogleSignInAuthentication googleAuth = await user.authentication;
  //       OAuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       await FirebaseAuth.instance
  //           .signInWithCredential(credential)
  //           .catchError((dynamic onSigninCredsError) {
  //         throw onSigninCredsError.toString();
  //       });
  //       isSigningIn = false;
  //     }
  //   } on PlatformException catch (err) {
  //     throw err.toString();
  //   } catch (error) {
  //     throw error.toString();
  //   }
  // }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .onError((Object? error, StackTrace stackTrace) async {});
      await FirebaseAuth.instance.signOut();
    } on PlatformException catch (err) {
      throw err.toString();
    } catch (error) {
      throw error.toString();
    }
  }
}
