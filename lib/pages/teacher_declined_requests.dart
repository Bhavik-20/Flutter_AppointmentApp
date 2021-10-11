import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard_declined.dart';
import 'package:flutter_appointment_app/pages/teacher_history_declined.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';

// void main()
// {
//   runApp(teacher_declined_requests());
// }

class teacher_declined_requests extends StatefulWidget {
  final bool i;
  teacher_declined_requests({this.i});

  @override
  _teacher_declined_requestsState createState() => _teacher_declined_requestsState(i: i);
}

class _teacher_declined_requestsState extends State<teacher_declined_requests> {
  final bool i;
  _teacher_declined_requestsState({this.i});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return i ? StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_rejected,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofRejectedRequests(),
        )
    ): StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_rejected,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: teacher_history_declined(),
        )
    );
  }
}
