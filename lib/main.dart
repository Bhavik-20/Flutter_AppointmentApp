import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student_login.dart';
import 'package:flutter_appointment_app/pages/teacher_login.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      //'/': (context) => role()
      '/': (context) => student_login()
    },
  ));
}

