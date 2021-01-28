import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotScreen extends StatefulWidget{
  @override
  State<StatefulWidget>createState() {

    return _ForgotScreen();
  }
    }
    class _ForgotScreen extends State<ForgotScreen>{
      String email="";
      String email_t = "";
      StreamSubscription<DocumentSnapshot> ss;

      // var _formKey=GlobalKey<FormState>();

      checkUserExists(String email) async
      {
        final QuerySnapshot ans_stud = await Firestore.instance
            .collection('student')
            .where('email', isEqualTo: email)
            .limit(1)
            .getDocuments();
        final QuerySnapshot ans_tea = await Firestore.instance
            .collection('faculty')
            .where('email', isEqualTo: email)
            .limit(1)
            .getDocuments();
        print("Length: "+ans_stud.documents.length.toString());
        if(ans_stud.documents.length==1 || ans_tea.documents.length==1)
          {
            return "Exists";
          }
        else
          {
            return "Not Exists";
          }
      }

      Future<String> validate(String email) async
      {
        RegExp ofemail=new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (email.isEmpty || !ofemail.hasMatch(email))
          return 'Invalid Email format';
        if(!email.contains('@somaiya.edu'))
          return 'Only Somaiya Email IDs are accepted';
        return 'valid';
      }

     @override
      Widget build(BuildContext context){
       Size size = MediaQuery.of(context).size;
       return Scaffold(
         backgroundColor: Colors.white,
         body: SafeArea(
           child:  SingleChildScrollView(
             child: Column(
               children: [
                 Row(
                   children: [
                     Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                     IconButton(
                       icon: Icon(Icons.arrow_back ),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
                     SizedBox(width: 30.0),
                     Text(
                       "Reset password",
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
                   height: size.height * 0.3,
                   width: size.width * 0.7,
                   child: Image(
                     image: AssetImage('images/email_verify.png'),
                   ),
                 ),
                 SizedBox(height: size.height * 0.03),
                 Form(
                  // key: _formKey,
                   child: Column(
                    children:<Widget> [
                      RoundedInputField(
                        hintText: "Your Email",
                        onChanged: (value) {
                          setState(() => email=value);
                        },
                      ),
                      Padding(
                        padding:EdgeInsets.only(left:0,top:15,right:0,bottom:0),
                        child:RoundedButton(
                          press:() async {
                            print("Email : " + email);
                            String valid= await validate(email);
                            print("Valid : " + valid);
                            if(valid=="valid")
                            {
                              String result = await checkUserExists(email);
                              print("Result : " + result);
                              if(result=="Exists")
                                {
                                  FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: email).then((value) =>
                                      print("Check your mails..."));
                                  Fluttertoast.showToast(
                                    backgroundColor: Colors.green,
                                    msg: 'A password Link has been sent to your Email Id',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                  );
                                  setState(() {
                                    email_t = "sent";
                                  });
                                }
                              else
                                {
                                  Fluttertoast.showToast(
                                    backgroundColor: Colors.red,
                                    msg: 'We have no user with this email Id',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                  );
                                }
                             }
                            else
                              {
                                Fluttertoast.showToast(
                                  backgroundColor: Colors.red,
                                  msg: 'Invalid Email',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP
                                );
                              }
                            },
                          text: "Send Reset Link",
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      if(email_t == "sent")
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal : 10.0),
                              child: Text('A link to reset your password has been sent to your email.',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal : 10.0),
                              child: Text('You May Login after Resetting your Password',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: kPrimaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: size.width * 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                  color: kPrimaryLightColor,
                                  onPressed: (){
                                    Navigator.of(context).pushNamed('/st_login');
                                  },
                                  child: Text(
                                    'Go To Login',
                                    style: TextStyle(color: kPrimaryColor, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )
                    ],
                 )
                 ),
               ],
             ),
           ),
         ),
       );
     }
}