import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/student_dashboard.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => student_dashboard()
    },
  ));
}

