import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/student_dashboard_new.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';


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