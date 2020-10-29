import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/services/constants.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
import 'package:flutter_appointment_app/services/text_field_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(teacher_signup());
}

class teacher_signup extends StatelessWidget {
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
                    "Teacher Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'dosis',
                        fontSize: 40
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset('icons/teacher.svg', height:200),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Full Name",
                onChanged: (value) {},
              ),
              TextFieldContainer(
                child: TextField(
                  onChanged: (value) {},
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
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.room
                      ,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Room Number',
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email
                      ,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Somaiya Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              RoundedButton(
                text: "Sign Up",
                press: () {},
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
                    Text("Already Signed Up?",
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryLightColor,
                    onPressed: (){},
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
    );
  }
}
