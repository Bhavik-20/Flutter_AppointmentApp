import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/teacher_history_new.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';

import 'teacher_dashboard_new.dart';

class teacher_new_requests extends StatefulWidget {
  final bool i;
  teacher_new_requests({this.i});
  @override
  _teacher_new_requestsState createState() => _teacher_new_requestsState(i: i);
}

class _teacher_new_requestsState extends State<teacher_new_requests> {
  final bool i;
  _teacher_new_requestsState({this.i});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return  i ? StreamProvider<List<Request>>.value (
        value: DatabaseService(uid: user.user_id).teacher_unanswered,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofnewFacultyRequests(),
        )
    ) : StreamProvider<List<Request>>.value (
        value: DatabaseService(uid: user.user_id).teacher_unanswered,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: teacher_history_new(),
        )
    );
  }
}


