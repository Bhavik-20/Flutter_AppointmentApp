import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/teacher_accepted_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_declined_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_new_requests.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(teacher_history());
}

class teacher_history extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                tabs:[
                  Tab(icon: Icon(Icons.list), text: "Unanswered"),
                  Tab(icon: Icon(Icons.check_circle), text: "Accepted"),
                  Tab(icon: Icon(Icons.remove_circle), text: "Rejected"),
                ],
              labelPadding: EdgeInsets.all(5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width:5, color: Colors.white),
              ),
            ),
            title: Text('Teacher History'),
            centerTitle: true ,
            elevation: 10,
            backgroundColor: Colors.deepPurple[600],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
                // Navigator.of(context).pushNamed('/tea_dash');
              },
            ),
          ),
          body: TabBarView(
            children: [
              teacher_new_requests(i: false),
              teacher_accepted_requests(),
              teacher_declined_requests(),
            ],
          ),
        ),
      ),
    );
  }
}
