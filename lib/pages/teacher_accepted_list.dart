import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main()
{
  runApp(teacher_accepted_list());
}

class teacher_accepted_list extends StatefulWidget {
  @override
  _teacher_accepted_listState createState() => _teacher_accepted_listState();
}

class _teacher_accepted_listState extends State<teacher_accepted_list> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
        body: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index){
              return Card(
                margin: EdgeInsets.fromLTRB(16, 16, 16,0),
                child: ListTile(
                  onTap: (){
                    // Navigator.of(context).pushNamed('/tea_reqdetails');
                  },
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
