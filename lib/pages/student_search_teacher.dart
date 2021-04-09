import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/teacher_search_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/services/database.dart';

class student_search_teacher extends StatefulWidget {

  @override
  _student_search_teacherState createState() => _student_search_teacherState();
}

class _student_search_teacherState extends State<student_search_teacher> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return StreamProvider<List<Teacher>>.value(
      value: DatabaseService().faculties,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/st_dash');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          actions:<Widget> [
            IconButton(
                icon: Icon(Icons.search),
                onPressed:(){
                } )
          ],
          backgroundColor: Colors.deepPurple[600],
          title: Text('List Of Teachers',
            style:TextStyle(
              fontSize: size.width*0.05,
            ) ,),
          centerTitle: true,
        ),
        body: SearchList(),
      ),
    );
  }
}
