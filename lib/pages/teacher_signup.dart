import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class teacher_signup extends StatefulWidget {
  @override
  _teacher_signupState createState() => _teacher_signupState();
}

class _teacher_signupState extends State<teacher_signup> {

  final _formKey=GlobalKey<FormState>();
  final AuthService _auth=AuthService();

  //text field state
  String name="";
  String emp_code="";
  String initials="";
  String room="";
  String email = "";
  String password = "";
  String error="";
  String timetable='';
  bool loading=false;

  String validate(String name,String emp_code, String initials, String room, String email, String password) {
    RegExp ofname=new RegExp(r'^[A-Za-z ]*$');
    RegExp ofcode=new RegExp(r'^[0-9]{1,6}$');
    RegExp ofini=new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroom=new RegExp(r'^[A-Za-z0-9\-]*$');
    RegExp ofemail=new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (emp_code.isEmpty || !ofcode.hasMatch(emp_code))
      return 'Invalid Employee Code';
    if (initials.isEmpty || !ofini.hasMatch(initials))
      return 'Invalid Initials';
    if (room.isEmpty || !ofroom.hasMatch(room))
      return 'Invalid Room Number';
    if (email.isEmpty || !ofemail.hasMatch(email))
      return 'Invalid Email format';
    if(!email.contains('@somaiya.edu'))
      return 'Only Somaiya Email IDs are accepted';
    if (password.isEmpty || password.length<6)
      return 'Password length should be 6 char';
    return 'valid';
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading? Loading(): Form(
      key: _formKey,
      child: Scaffold(
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
                        // Navigator.of(context).pushNamed('/tea_login');
                      },
                    ),
                    SizedBox(width: size.width*0.05),
                    Text(
                      "Teacher Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'dosis',
                          fontSize: size.height*0.04,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset('icons/teacher.svg', height:200),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Full Name",
                  onChanged: (value) {
                    setState(() => name=value);
                  },
                ),
                TextFieldContainer(
                  child: TextField(
                    onChanged: (value) {
                      setState(() => emp_code=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.code,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Teacher Code',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    onChanged: (value) {
                      setState(() => initials=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.sort_by_alpha
                        ,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Initials',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    onChanged: (value) {
                      setState(() => room=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.room,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Room Number',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    onChanged: (value) {
                      setState(() => email=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Somaiya Email',
                      border: InputBorder.none,
                    ),
                  ),
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                RoundedButton(
                  text: "Sign Up",
                  press: () async {
                    String result=validate(name,emp_code,initials,room,email,password);
                    if(result=='valid')
                      {
                        setState(() => loading=true);
                        dynamic result_auth = await _auth.registerFaculty(name,emp_code,initials,room,email,password,'',timetable);
                        if(result_auth == null)
                        {
                          setState(() {
                            loading=false;
                            error ='An error occurred, please supply valid input';
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: error,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          });
                        }
                        else
                        {
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          prefs.setInt(user.uid, 3);
                          prefs.setString('role', 'Teacher');
                          Navigator.of(context).pushNamed('/st_verify');
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
                SizedBox(height: size.height * 0.03),
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.purple[100],
                          )
                      ),
                      SizedBox(width: 5.0,),
                      Text("Already Signed Up?",
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
                        Navigator.pop(context);
                        // Navigator.of(context).pushNamed('/tea_login');
                      },
                      child: Text(
                        'Sign In here',
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


