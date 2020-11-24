import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/List_studentNewRequest.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:provider/provider.dart';

import 'List_teacherNewRequest.dart';

class student_new_requests extends StatefulWidget {
  @override
  _student_new_requestsState createState() => _student_new_requestsState();
}

class _student_new_requestsState extends State<student_new_requests> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return  StreamProvider<List<Request>>.value(
        value: DatabaseService(uid:user.user_id).student_unanswered,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofnewStudentRequests(),
        )
    );
  }
}