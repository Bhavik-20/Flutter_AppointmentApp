import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/teacher_history_accepted.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';

import 'teacher_dashboard_accepted.dart';

// void main()
// {
//   runApp(teacher_accepted_requests());
// }

class teacher_accepted_requests extends StatefulWidget {
  final bool i;
  teacher_accepted_requests({this.i});

  @override
  _teacher_accepted_requestsState createState() => _teacher_accepted_requestsState(i: i);
}

class _teacher_accepted_requestsState extends State<teacher_accepted_requests> {
  final bool i;
  _teacher_accepted_requestsState({this.i});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(i);
    return i ? StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_accepted,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofAcceptedRequests(),
        )
    ): StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).teacher_accepted,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: teacher_history_accepted(),
        )
    );
  }
}

