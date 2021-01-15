import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/List_studentAcceptedRequests.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'List_teacherAcceptedRequests.dart';

void main()
{
  runApp(student_verify());
}

class student_verify extends StatefulWidget {
  @override
  _student_verifyState createState() => _student_verifyState();
}

class _student_verifyState extends State<student_verify> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
        minimum: EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                    IconButton(
                      icon: Icon(Icons.arrow_back ),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/st_login');
                      },
                    ),
                    SizedBox(width: 50.0),
                    Text(
                      "Email Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dosis',
                          fontSize: 40
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  height: 275,
                  width: 275,
                  child: Image(
                    image: AssetImage('images/email_verify.png'),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text(
                    'An Email has been sent to you with a verification link , '
                        'please check your mail box and then click verify.',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Text(
                    'Please note that you have only 3 tries.',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: kPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedButton(
                  text: "Verify",
                  press: () {}

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
                      onPressed: (){

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
    );
  }
}

