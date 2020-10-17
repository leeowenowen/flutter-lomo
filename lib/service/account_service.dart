
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_photo_share/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountService {
  static FirebaseAuth _auth;
  static GoogleSignIn _googleSignIn;
 static User _currentUserModel;

  static init(){
    _auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
  }

  static FirebaseAuth firebaseAuth() {
    return _auth;
  }

  static GoogleSignIn googleSignIn(){
    return _googleSignIn;
  }

  static setCurrentUser(User user){
    _currentUserModel = user;
  }

  static User currentUser(){
    return _currentUserModel;
  }

  static logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _currentUserModel = null;
  }
}