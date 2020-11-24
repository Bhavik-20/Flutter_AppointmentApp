import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/List_teacherRejectedRequests.dart';
import 'package:flutter_appointment_app/services/database.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

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
    return StreamProvider<List<Request>>.value(
        value: DatabaseService().rejectedRequests,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofRejectedRequests(),
        )
    );
  }
}
