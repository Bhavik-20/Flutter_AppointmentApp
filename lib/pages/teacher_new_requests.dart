import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:provider/provider.dart';

import 'List_teacherNewRequest.dart';

class teacher_new_requests extends StatefulWidget {
  @override
  _teacher_new_requestsState createState() => _teacher_new_requestsState();
}

class _teacher_new_requestsState extends State<teacher_new_requests> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return  StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_unanswered,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofnewFacultyRequests(),
        )
    );
  }
}


