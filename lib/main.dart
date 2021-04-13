import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/TimeTable.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/student_verify.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:flutter_appointment_app/services/Api.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/services/route_generator.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/wrapper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher(){
  Workmanager.executeTask((taskName, inputData) async {
    if(taskName == "copyTTSlots")
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String uid = prefs.getString("id_user");
        String day_to_copy="";
        if(uid.isNotEmpty)
        {
          print("BG TASK");
          CollectionReference bgtask = Firestore.instance.collection("faculty").document(uid).collection("timetable");
          DocumentReference doc_bgtask = bgtask.document(uid);
          var date = DateTime.now();
          var curr_day = DateFormat('EEEE').format(date);
          curr_day=curr_day.toLowerCase().trim();
          print("CURRENT DAY: "+curr_day);
          List doc_data;

            if(curr_day == "saturday")
            {
              day_to_copy = "fri";
              // static_day=static_fri;
            }
            else if(curr_day == "tuesday")
            {
              day_to_copy = "mon";
              // static_day=static_mon;
            }
            else if(curr_day == "wednesday")
            {
              day_to_copy = "tue";
              // static_day=static_tue;
            }
            else if(curr_day == "thursday")
            {
              day_to_copy = "wed";
              // static_day=static_wed;
            }
            else if(curr_day == "friday")
            {
              day_to_copy = "thurs";
              // static_day=static_thurs;
            }
            print("DAY TO COPY: "+day_to_copy);
            // print("STATIC DAY: "+static_day.toString());
            String fieldname1 = "dynamic_"+day_to_copy;
            String fieldname2 = "static_"+day_to_copy;
            print("FIELD NAME 1: "+fieldname1);
            print("FIELD NAME 2: "+fieldname2);
            await doc_bgtask.get().then((documentSnapshot) {
              print("DOCUMENTSNAPSHOT: "+documentSnapshot.data.toString());
              doc_data = documentSnapshot.data[fieldname2];
              print("INSIDE DOC DATA: "+doc_data.toString());
            });
            print("DOC DATA: "+doc_data.toString());
            await doc_bgtask.updateData({
              fieldname1 : doc_data,
            });
            // }
        }
      }
      return Future.value(true);
      });
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher);
  await Workmanager.registerPeriodicTask("1", "copyTTSlots",
    frequency: Duration(minutes: 15),
    initialDelay: Duration(minutes: 1),
  );
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