import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';
import 'student_dashboard_declined.dart';


void main()
{
  runApp(student_declined_requests());
}

class student_declined_requests extends StatefulWidget {
  @override
  _student_declined_requestsState createState() => _student_declined_requestsState();
}

class _student_declined_requestsState extends State<student_declined_requests> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Request>>.value(
        value: DatabaseService(uid: user.user_id).student_rejected,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: listofStudentDeclinedRequests(),
        )
    );
  }
}

