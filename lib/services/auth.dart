import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User1? _userFromFirebaseUser(User user) {
    return user != null ? User1(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User1?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
    // return _auth.onAuthStateChanged
    //   .map(_userFromFirebaseUser);
  }

  // sign in anonomously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String user_name,String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(user_name,email,password);
      // print("user data updated");
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}