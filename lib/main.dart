import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/student_verify.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/route_generator.dart';
import 'package:flutter_appointment_app/wrapper.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: student_verify(),
        // Wrapper(),
        // // initialRoute: '/',
        // onGenerateRoute: RouteGenerator.generateRoute,

      ),
    );
  }
}