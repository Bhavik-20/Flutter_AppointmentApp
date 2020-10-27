import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(teacher_login());
}

class teacher_login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    onPressed: (){},
                  ),
                  SizedBox(width: 50.0),
                  Text(
                    "Teacher Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'dosis',
                        fontSize: 40
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset('icons/teacher.svg', height:250),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              RoundedButton(
                text: "LOGIN",
                press: () {},
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
                    Text("OR",
                      style: TextStyle(
                          fontFamily: 'dosis',
                          fontWeight: FontWeight.bold
                      ),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
