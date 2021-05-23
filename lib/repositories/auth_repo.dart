import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schedule_app/models/user.dart' as app_user;
import 'package:schedule_app/utils/prefs.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  AuthRepository() {
    _checkForAuthStatus();
  }

  app_user.User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status => _controller.stream;

  void _checkForAuthStatus() async {
    await tryToGetUser();
    if (_user != null) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  Future<app_user.User> tryToGetUser() async {
    if (_user == null) {
      _user = await PreferenceManager.getUser();
    }
    return _user;
  }

  void signInWithPhoneNumber(
    String code,
    String number,
  ) {
    _auth.verifyPhoneNumber(
      phoneNumber: '$code$number',
      timeout: Duration(seconds: 30),
      verificationCompleted: (firebaseUser) {},
      codeSent: (verificationId, [forceResendingToken]) async {
        // Sign the user in (or link) with the credential
      },
      verificationFailed: (error) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final firebaseUser = userCredential.user;

    _user = _saveUser(firebaseUser);

    // Change auth status
    _controller.add(AuthenticationStatus.authenticated);
  }

  app_user.User _saveUser(User firebaseUser) {
    final user = app_user.User(
      username: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      picUrl: firebaseUser.photoURL,
      contact: firebaseUser.phoneNumber,
    );

    PreferenceManager.saveUser(user);

    return user;
  }

  Future<void> signOut() async {
    // Sign out from Firebase
    await _auth.signOut();
    // Sign out from Google
    GoogleSignIn().signOut();
    // Clear prefs
    await PreferenceManager.clearSensitivePrefs();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
