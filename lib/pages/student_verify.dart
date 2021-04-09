import 'dart:ffi';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/student_dashboard_accepted.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'teacher_dashboard_accepted.dart';

void main()
{
  runApp(student_verify());
}

class student_verify extends StatefulWidget {
  @override
  _student_verifyState createState() => _student_verifyState();
}

class _student_verifyState extends State<student_verify> {

  bool loading=false;
  final AuthService _auth=AuthService();
  String tries="3";

  Future<FirebaseUser> DeleteUser()
  async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    CollectionReference studColl=Firestore.instance.collection('student');
    DocumentReference studDoc=studColl.document(uid);
    await studDoc.delete();
    return user;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading? Loading() : WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
          minimum: EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: Text(
                      "Email Verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dosis',
                        fontSize: size.width*0.1,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    height: size.height *0.3,
                    width: size.width *0.6,
                    child: Image(
                      image: AssetImage('images/email_verify.png'),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Text(
                      'An Email has been sent to you with a verification link , '
                          'please check your mail and verify your account.',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Text(
                      'Please note that you have only 3 tries to verify your email.',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  //   child: Text(
                  //     'Tries : '+tries,
                  //     style: GoogleFonts.lato(
                  //       fontSize: 18,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  // SizedBox(height: size.height * 0.01),
                  RoundedButton(
                    text: "Verify",
                    press: () async {
                      setState(() {loading=true;});

                      FirebaseUser _user =  await FirebaseAuth.instance.currentUser();
                      await _user.reload();
                      _user =  await FirebaseAuth.instance.currentUser();
                      if(_user.isEmailVerified)
                        {
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          String role=prefs.getString('role');
                          if(role == 'Student') {
                            print(role);
                            Navigator.of(context).pushNamed('/stu_tips');
                          }
                          else if(role == 'Teacher') {
                            await prefs.setString("id_user", _user.uid);
                            print(role);
                            Navigator.of(context).pushNamed('/tea_tips');
                          }
                        }
                      else
                        {
                          print('1 : =================================================');
                          setState(() {loading=false;});
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          int chances=prefs.getInt(user.uid);
                          if(chances>1)
                            {
                              print("Chances before: "+chances.toString());
                              chances=chances-1;
                              prefs.setInt(user.uid, chances);
                              Fluttertoast.showToast(
                                backgroundColor: Colors.red,
                                msg: 'You Have Not verified your email.\nATTEMPTS LEFT='+chances.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              print("Chances after: "+chances.toString());
                              tries = chances.toString();
                            }
                          else
                            {
                              setState(() {loading=true;});
                              print('2 : =================================================');
                              FirebaseUser remove_user= await DeleteUser();
                              await remove_user.delete();
                              await _auth.signOut();
                              Fluttertoast.showToast(
                                backgroundColor: Colors.red,
                                msg: 'Your Account has been deleted from our Database. Please Sign Up Again',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              prefs.remove(user.uid);
                              prefs.remove("file_tt");
                              Navigator.of(context).pushNamed('/');
                            }
                        }
                    }

                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: size.width * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryLightColor,
                        onPressed: () async {
                          setState(() => loading=true);
                          print("Verify : Sign Out");
                          await Future.delayed(const Duration(milliseconds: 3000));
                          await _auth.signOut();
                          Navigator.of(context).pushNamed('/');
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ),
      ),
      ),
    );
  }
}

