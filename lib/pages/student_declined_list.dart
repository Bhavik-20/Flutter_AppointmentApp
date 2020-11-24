import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/List_studentAcceptedRequests.dart';
import 'package:flutter_appointment_app/services/database.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'List_studentDeclinedRequests.dart';
import 'List_teacherAcceptedRequests.dart';

void main()
{
  runApp(student_declined_list());
}

class student_declined_list extends StatefulWidget {
  @override
  _student_declined_listState createState() => _student_declined_listState();
}

class _student_declined_listState extends State<student_declined_list> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Request>>.value(
        value: DatabaseService().rejectedRequests,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofStudentDeclinedRequests(),
        )
    );
  }
}

