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
import 'package:shared_preferences/shared_preferences.dart';

class ForgotScreen extends StatefulWidget{
  @override
  State<StatefulWidget>createState() {

    return _ForgotScreen();
  }
    }
    class _ForgotScreen extends State<ForgotScreen>{
      String email="";
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
        return 'valid';
      }

     @override
      Widget build(BuildContext context){

       return Scaffold(
         backgroundColor: Colors.white,
         body: Center(
           child: Padding(padding: EdgeInsets.only(top: 50,left:20,right:20),
            child:Form(
             // key: _formKey,
              child: Column(
               children:<Widget> [
                 Text(
                   "We will send you a link ... Please click on that link to reset your password",
                 style: TextStyle(color: Color(0xffffffff),fontSize: 20),
                 ),
                 SizedBox(height:20),
                 RoundedInputField(
                   hintText: "Your Email",
                   onChanged: (value) {
                     setState(() => email=value);
                   },
                 ),
                 Padding(
                   padding:EdgeInsets.only(left:0,top:15,right:0,bottom:0),
                   child:RaisedButton(
                     onPressed:() async {
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
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(50),
                     ),
                     color: kPrimaryColor,
                     child: Text("Send Email",style:TextStyle(color:Colors.white,fontSize:20),),
                      padding: EdgeInsets.all(10),
                   ),
                 ),
               ],
           )
           ),
         ),
       ),
       );
     }
}