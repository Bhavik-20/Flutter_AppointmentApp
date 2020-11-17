import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';

class student_profile extends StatefulWidget {
  @override
  _student_profileState createState() => _student_profileState();
}

class _student_profileState  extends State<student_profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/st_dash');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[600],
        title: Text('Student Profile'),
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
                              labelText: 'Student Name',
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
                              labelText: 'Student Roll No',
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
                              labelText: 'Branch',
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
                              labelText: 'Year',
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
                              labelText: 'Somaiya Email',
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
                Navigator.of(context).pushNamed('/st_dash');
              },
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}
