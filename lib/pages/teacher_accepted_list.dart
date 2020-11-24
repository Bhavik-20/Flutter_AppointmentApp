import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/services/database.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'List_teacherAcceptedRequests.dart';

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
    return StreamProvider<List<Request>>.value(
        value: DatabaseService().acceptedRequests,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofAcceptedRequests(),
        )
    );
  }
}

