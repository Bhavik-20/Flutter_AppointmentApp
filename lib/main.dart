import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/student_verify.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/route_generator.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs= await SharedPreferences.getInstance();
//   // print("MAIN: "+prefs.getString("role"));
//   var loggedIn_user = prefs.getString("role");
//   runApp(MaterialApp(
//     home: loggedIn_user == null ? role() : Loading(),
//     onGenerateRoute: RouteGenerator.generateRoute,
//   ));
// }

void main()
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}