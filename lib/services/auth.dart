import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appointment_app/model/Teachers.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  Teachers _userFromFirebaseUser(FirebaseUser user){
    return user != null ? Teachers (teacher_id: user.uid) : null;
  }

  //auth change user stream
  Stream<Teachers> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
   try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
    } catch(e){
     print(e.toString());
     return null;
   }
  }

  // sign out
}