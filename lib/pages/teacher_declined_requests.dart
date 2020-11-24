import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/List_teacherDeclinedRequests.dart';
import 'package:flutter_appointment_app/services/database.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(teacher_declined_requests());
}

class teacher_declined_requests extends StatefulWidget {
  @override
  _teacher_declined_requestsState createState() => _teacher_declined_requestsState();
}

class _teacher_declined_requestsState extends State<teacher_declined_requests> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_rejected,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofRejectedRequests(),
        )
    );
  }
}
