import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  FirebaseAuth auth;

  AuthState(this.auth);

  Stream<User?> get userChanges => auth.idTokenChanges();

  Future signInWithEmail({String? email, String? password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('Invalid email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOnWithEmail({String? email, String? password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      signInWithEmail(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    await auth.signOut();
  }
}
