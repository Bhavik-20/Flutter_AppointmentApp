import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user==null) {
      return role();
    }

    else
    {
      return teacher_dashboard();
    }
  }

}
