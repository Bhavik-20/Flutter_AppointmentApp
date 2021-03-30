import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/services/SharedPrefHelper.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appointment_app/pages/ForgotScreen.dart';

void main(){
  runApp(student_login());
}
class student_login extends StatefulWidget {
  @override
  _student_loginState createState() => _student_loginState();
}

class _student_loginState extends State<student_login> {

  final AuthService _auth=AuthService();

  //text field state
  String email = "";
  String error="";
  String password = "";
  bool loading=false;

  Future<String> validate(String email, String password) async
  {
    RegExp ofemail=new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty || !ofemail.hasMatch(email))
      return 'Invalid Email format';
    if (password.isEmpty || password.length<6)
      return 'Password length should be 6 char';
    if(!email.contains('@somaiya.edu'))
      return 'Only Somaiya Email IDs are accepted';
    return 'valid';
  }

  Future<String> check_role() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final docid = user.uid;
    CollectionReference check=await Firestore.instance.collection('student');
    var doc = await check.document(docid).get();
    print("CHECK: "+docid+" - "+doc.exists.toString());
    return doc.exists.toString();
  }

 bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading? Loading(): Form(
      child: Scaffold(
        //backgroundColor: Colors.deepPurple[100],
        body: SafeArea(
          minimum: EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                    IconButton(
                      icon: Icon(Icons.arrow_back ),
                      onPressed: (){
                        Navigator.pop(context);
                        // Navigator.of(context).pushNamed('/');
                      },
                    ),
                    SizedBox(width: 50.0),
                    Text(
                      "Student Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dosis',
                          fontSize: 40
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Image(
                  image: AssetImage('images/student.jpg'),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {
                    setState(() => email=value);
                  },
                ),
                TextFieldContainer(
                  child: TextField(
                    obscureText: !this._showPassword,
                    onChanged: (value) {
                      setState(() => password=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          this._showPassword ? Icons.visibility_off : Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() => this._showPassword = !this._showPassword);
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                    child: Container(
                      width: double.infinity,
                      child: InkWell(
                        onTap:(){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(BuildContext context)=> ForgotScreen()));
                        },
                        child:Text("Forgot password ?",
                          style:TextStyle(
                            color:kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign :TextAlign.right ,
                        ),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    String result=await validate(email,password);
                    if(result=='valid')
                    {
                      setState(() => loading=true);
                      dynamic result_auth = await _auth.signInWithEmailAndPassword(email, password);
                      if(result_auth == null)
                      {
                        setState(()  {loading=false;});
                        error ='An error occurred, please supply valid input';
                        Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          msg: error,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                      else
                      {
                        String result2= await check_role();
                        if(result2=='true')
                        {
                          Fluttertoast.showToast(
                            backgroundColor: Colors.green,
                            msg: 'Successful',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                          if(user.isEmailVerified)
                            {
                              print("Email Verified");
                              // await SharedPrefHelper.setStringPref("role", "Student");
                              SharedPreferences prefs=await SharedPreferences.getInstance();
                              await prefs.setString("role", "Student");
                              Navigator.of(context).pushNamed('/st_dash');
                            }
                          else
                            {
                              print("Email Not Verified");
                              Navigator.of(context).pushNamed('/st_verify');
                            }
                        }
                        else
                        {
                          Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            msg: 'You do not belong to the Student Role.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          await _auth.signOut();
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed('/');
                        }
                      }
                    }
                    else {
                      Fluttertoast.showToast(
                        backgroundColor: Colors.red,
                        msg: result,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                      );
                    }
                  },
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(height: 10.0,),
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.purple[100],
                          )
                      ),
                      SizedBox(width: 5.0,),
                      Text("Not Registered?",
                        style: TextStyle(
                            fontFamily: 'dosis',
                            fontWeight: FontWeight.bold,
                            fontSize:15.0
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.purple[100],
                          )
                      ),
                    ]
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
                        Navigator.of(context).pushNamed('/st_signup');
                      },
                      child: Text(
                        'Sign Up here',
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
