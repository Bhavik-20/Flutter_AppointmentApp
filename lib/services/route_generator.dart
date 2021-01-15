import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/main.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student_login.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/pages/student_signup.dart';
import 'package:flutter_appointment_app/pages/student_verify.dart';
import 'package:flutter_appointment_app/pages/teacher_accepted_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:flutter_appointment_app/pages/teacher_declined_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_history.dart';
import 'package:flutter_appointment_app/pages/teacher_login.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/pages/teacher_request_status.dart';
import 'package:flutter_appointment_app/pages/teacher_signup.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/student_search_teacher.dart';
import 'package:flutter_appointment_app/pages/student_profile.dart';
import 'package:flutter_appointment_app/pages/teacher_profile.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/student_accepted_requests.dart';
import 'package:flutter_appointment_app/pages/student_declined_requests.dart';
import 'package:flutter_appointment_app/pages/student_new_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_search_list.dart';
import 'package:flutter_appointment_app/pages/teacher_new_requests.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => role());
      case '/main':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/st_dash':
          return MaterialPageRoute(builder: (_) => student_dashboard());
      case '/st_bookAppo ':
        return MaterialPageRoute(builder: (_) => student_bookAppointment());
      case '/st_login':
        return MaterialPageRoute(builder: (_) => student_login());
      case '/st_profile':
        return MaterialPageRoute(builder: (_) => student_profile());
      case '/st_req_status':
        return MaterialPageRoute(builder: (_) => student_request_status());
      case '/st_search_teacher':
        return MaterialPageRoute(builder: (_) => student_search_teacher());
      case '/st_signup':
        return MaterialPageRoute(builder: (_) => student_signup());
      case '/st_acc_req':
        return MaterialPageRoute(builder: (_) => student_accepted_requests());
      case '/st_dec_req':
        return MaterialPageRoute(builder: (_) => student_declined_requests());
      case '/st_new_req':
        return MaterialPageRoute(builder: (_) => student_new_requests());
      case '/tea_acc_list':
        return MaterialPageRoute(builder: (_) => teacher_accepted_requests());
      case '/tea_dash':
        return MaterialPageRoute(builder: (_) => teacher_dashboard());
      case '/tea_dec_list':
        return MaterialPageRoute(builder: (_) => teacher_declined_requests());
      case '/tea_history':
        return MaterialPageRoute(builder: (_) => teacher_history());
      case '/tea_login':
        return MaterialPageRoute(builder: (_) => teacher_login());
      case '/tea_new_req':
        return MaterialPageRoute(builder: (_) => teacher_new_requests());
      case '/tea_profile':
        return MaterialPageRoute(builder: (_) => teacher_profile());
      case '/tea_req_details':
        return MaterialPageRoute(builder: (_) => teacher_request_details());
      case '/tea_req_status':
        return MaterialPageRoute(builder: (_) => teacher_request_status());
      case '/tea_search_list':
        return MaterialPageRoute(builder: (_) => SearchList());
      case '/tea_signup':
        return MaterialPageRoute(builder: (_) => teacher_signup());
      case '/stu_verify':
        return MaterialPageRoute(builder: (_) => student_verify());

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR Loading selected page. Go back and try again :)'),
        ),
      );
    });
  }
}