import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/services/constants.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(student_app_details());
}

class student_app_details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[600],
        title: Text('Appointment Details'),
        centerTitle: true,
        actions: [
          Icon(Icons.wysiwyg_outlined)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                // color: Colors.white,
                width: size.width*0.8,
                child: Column(
                  children: [
                    Container(
                      height:50.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:50.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                            fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Roll number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:40.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Branch',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1.3,
                    ),
                    Container(
                      height:40.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Year',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:40.0,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Somaiya Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:40.0,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Date',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:40.0,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'kanit'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Time',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                // color: Colors.white,
                width: size.width*0.8,
                child: Container(
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'kanit'
                    ),
                    maxLines: 5,
                    autocorrect: false,
                    autofocus: false,
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(
                      hintText: 'Purpose of Meet',
                      border: InputBorder.none,
                    ),
                  ),
                ),
            )
            ),
            SizedBox(height: 20.0,),
            Center(
              child: RoundedButton(
                text: "Submit",
                press: () {},
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}