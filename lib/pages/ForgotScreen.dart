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
    //TODO: implement createState
    return _ForgotScreen();
  }
    }
    class _ForgotScreen extends State<ForgotScreen>{
      String email="";

      var _formKey=GlobalKey<FormState>();

      checkUserExists(String email) async{
        CollectionReference studColl= Firestore.instance.collection('student');
        var snap= await studColl.where("email",isEqualTo: email).getDocuments();
        if(snap.documents.isEmpty)
          {
            return "Not Exists";
          }
        else
          {
            return "Exists";
          }
      }

     @override
      Widget build(BuildContext context){
       //TODO: implement build
       return Scaffold(
         backgroundColor: Colors.white,
         body: Center(
           child: Padding(padding: EdgeInsets.only(top: 50,left:20,right:20),
           child:Form(
             key: _formKey,
           child: Column(
               children:<Widget> [
                 Text("We will send you a link ... Please click on that link to reset your password",
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
                     onPressed:() async{
                       if(_formKey.currentState.validate()){
                         String result = await checkUserExists(email);
                         if(result=="Exists") {
                           FirebaseAuth.instance.sendPasswordResetEmail(
                               email: email).then((value) =>
                               print("Check your mails..."));
                         }
                         else
                           {
                             Fluttertoast.showToast(
                               backgroundColor: Colors.red,
                               msg: 'We have no user with this email Id',
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.BOTTOM,
                             );
                           }
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