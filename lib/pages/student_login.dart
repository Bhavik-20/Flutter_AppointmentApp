import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  String password = "";
  bool loading=false;

  String validate(String email, String password)
  {
    RegExp ofemail=new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty || !ofemail.hasMatch(email))
      return 'Invalid Email format';
    if (password.isEmpty || password.length<6)
      return 'Password length should be 6 char';
    return 'valid';
  }

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
                        Navigator.of(context).pushNamed('/');
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
                RoundedPasswordField(
                  onChanged: (value) {
                    setState(() => password=value);
                  },
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    String result=validate(email,password);
                    if(result=='valid')
                    {
                      setState(() => loading=true);
                      dynamic result_auth = await _auth.signInWithEmailAndPassword(email, password);
                      if(result_auth == null)
                      {
                        setState(()  {
                          loading=false;
                          Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            msg: 'An error occurred, please supply valid input',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        });
                      }
                      else
                      {
                        setState(() => loading=true);
                        Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          msg: 'Successful',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.of(context).pushNamed('/st_dash');
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
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.purple[100],
                          )
                      ),
                      SizedBox(width: 5.0,),
                      Text("OR",
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
                SizedBox(height: 10.0,),
                FlatButton(
                  shape:  CircleBorder(
                      side: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.white
                      )
                  ),
                  onPressed: (){},
                  child: Image(
                    image: AssetImage('images/google.jpg'),
                    height: 70.0,
                    width: 50.0,
                  ),
                  // height: size.height*0.01,
                ),
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

