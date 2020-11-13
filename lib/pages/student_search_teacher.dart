import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/services/constants.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main(){
  runApp(search_teacher());
}

class search_teacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[600],
        title: Text('List Of Teachers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              // color: Colors.white,
              width: size.width*0.8,
              child: TextField(
                autocorrect: false,
                autofocus: false,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  hintText: 'Teacher Name',
                  icon: Icon(Icons.search,color: Colors.deepPurple[600],),
                  border: InputBorder.none,
                  ),
                  ),
              ),
            ),
          SizedBox(height: 30.0,),
          Center(
            child: Container(
              width: size.width*0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){},
                    title: Text('Teacher 1'),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text('Teacher 2'),
                  ),
                  ListTile(
                    onTap: (){},
                    title:Text('Teacher 3'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}