import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';

class teacher_profile extends StatefulWidget {
  @override
  _teacher_profileState createState() => _teacher_profileState();
}

class _teacher_profileState extends State<teacher_profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/tea_dash');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[600],
        title: Text('Teacher Profile'),
        centerTitle: true,
        actions: [
          Icon(Icons.person_pin_rounded,
            size: 30.0,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.0,),
            Center(
                child: Align(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/google.jpg'),
                    radius: 70.0,
                  ),
                )
            ),
            SizedBox(height: 20.0,),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  width: size.width*0.8,
                  child: Column(
                      children: [
                        Container(
                          height:50.0,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'playfair',
                                fontWeight: FontWeight.bold
                            ),
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              labelText: 'Teacher Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.deepPurple[100],
                          thickness: 1,
                        ),
                        Container(
                          height:50.0,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'playfair',
                                fontWeight: FontWeight.bold
                            ),
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              labelText: 'Teacher Initials',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.deepPurple[100],
                          thickness: 1,
                        ),
                        Container(
                          height:50.0,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'playfair',
                                fontWeight: FontWeight.bold
                            ),
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              labelText: 'Room Number',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.deepPurple[100],
                          thickness: 1,
                        ),
                        Container(
                          height:50.0,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'playfair',
                                fontWeight: FontWeight.bold
                            ),
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ]
                  )
              ),
            ),
            SizedBox(height: 30.0,),
            RoundedButton(
              text: 'Save Changes',
              press: (){
                Navigator.of(context).pushNamed('/tea_dash');
              },
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}
