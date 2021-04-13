import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user)
  {
    // return user != null ? User (user_id: user.uid) : null;
    return user != null ? User (user_id: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // register faculty
  Future registerFaculty(String name,String emp_code, String initials,String room,String email, String password, String url,String timetable) async
  {
    try
    {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      user.sendEmailVerification();
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        msg: 'A verification email is sent to '+email+'. Please Verify your email and then sign in.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      //create a new document for the teacher with the uid
      await DatabaseService(uid:user.uid).updateFacultyData(name, emp_code, initials, room, email, "No free slots available" ,url);
      await DatabaseService(uid:user.uid).updateTimeTable([], [], [], [], [],[], [], [], [], []);
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  // register student
  Future registerStudent(String name,String rollno,String branch,String year,String email, String password, String url) async
  {
    try
    {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print("1");
      user.sendEmailVerification();
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        msg: 'A verification email is sent to '+email+'. Please Verify your email and then sign in.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      //create a new document for the student with the uid
      await DatabaseService(uid:user.uid).updateStudentData(name, rollno, branch, year,email, url);
      print("2");
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async
  {
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // return _userFromFirebaseUser(user);
      return user;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }



  // sign out
  Future signOut() async
  {
   try{
     print('Try success');
     return await _auth.signOut();
   }
   catch(e){
     print(e.toString());
     return null;
   }
  }
}