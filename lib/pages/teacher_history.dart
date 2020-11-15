import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/teacher_accepted_list.dart';
import 'package:flutter_appointment_app/pages/teacher_declined_list.dart';
import 'package:flutter_appointment_app/services/constants.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
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
                  Tab(icon: Icon(Icons.list), text: "All"),
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
            leading: Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Container(child: Text('All')
                ),
              ),

              teacher_accepted_list(),
              teacher_declined_list(),
            ],
          ),
        ),
      ),
    );
  }
}
