import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(student_dashboard());
}

class student_dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: Text('Student Dashboard'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration:BoxDecoration(
                  color: Colors.purple[400]
                ) ,
                child: Stack(
                  children: [
                    Align(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/google.jpg'),
                        radius: 60.0,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  FlatButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_rounded),
                        SizedBox(width: 20.0,),
                        Text('Profile',
                          style: TextStyle(
                              fontFamily: 'dosis',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined),
                        SizedBox(width: 20.0,),
                        Text('Book An Appointment',
                          style: TextStyle(
                              fontFamily: 'dosis',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                      color: Colors.black
                  ),
                  FlatButton(
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 20.0,),
                        Text('Sign Out',
                        style: TextStyle(
                          fontFamily: 'dosis',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.purple[400],
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
