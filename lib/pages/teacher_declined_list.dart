import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main()
{
  runApp(teacher_declined_list());
}

class teacher_declined_list extends StatefulWidget {
  @override
  _teacher_declined_listState createState() => _teacher_declined_listState();
}

class _teacher_declined_listState extends State<teacher_declined_list> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index){
            return Card(
              margin: EdgeInsets.fromLTRB(16, 16, 16,0),
              child: ListTile(
                onTap: (){},
                title: Text('Student'),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                trailing: Text('Date-Time'),
              ),
            );
          }
      ),
    );
  }
}