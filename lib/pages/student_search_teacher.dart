import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class student_search_teacher extends StatefulWidget {
  @override
  _student_search_teacherState createState() => _student_search_teacherState();
}

class _student_search_teacherState extends State<student_search_teacher> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/st_dash');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[600],
        title: Text('List Of Teachers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0,),
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
              child: TextField(
                autocorrect: false,
                autofocus: false,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  hintText: 'Teacher Name',
                  icon: Icon(Icons.search,color: Colors.deepPurple[600],),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0,),
          Center(
            child: Container(
              width: size.width*0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/st_bookAppo');
                    },
                    title: Text('Teacher 1'),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text('Teacher 2'),
                  ),
                  ListTile(
                    onTap: (){},
                    title:Text('Teacher 3'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
