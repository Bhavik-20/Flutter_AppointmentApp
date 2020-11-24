import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/List_studentAcceptedRequests.dart';
import 'package:flutter_appointment_app/services/database.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'List_teacherAcceptedRequests.dart';

void main()
{
  runApp(student_accepted_requests());
}

class student_accepted_requests extends StatefulWidget {
  @override
  _student_accepted_requestsState createState() => _student_accepted_requestsState();
}

class _student_accepted_requestsState extends State<student_accepted_requests> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).student_accepted,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofStudentAcceptedRequests(),
        )
    );
  }
}

