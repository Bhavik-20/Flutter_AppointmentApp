import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

void main()
{
  runApp(student_dashboard());
}

class student_dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[600],
            title: Text('Student Dashboard'),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration:BoxDecoration(
                    color: Colors.deepPurple[600]
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
                      onPressed: (){
                        Navigator.of(context).pushNamed('/st_profile');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_rounded),
                          SizedBox(width: 15.0,),
                          Text('Profile',
                            style: GoogleFonts.quicksand(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/st_search_teacher');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          SizedBox(width: 15.0,),
                          Text('Book An Appointment',
                            style: GoogleFonts.quicksand(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                        color: Colors.black
                    ),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 15.0,),
                          Text('Sign Out',
                          style: GoogleFonts.quicksand(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
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
            onPressed: (){
              Navigator.of(context).pushNamed('/st_search_teacher');
            },
            backgroundColor: Colors.deepPurple[600],
            child: Icon(Icons.add, size: 30),

          ),
        ),
      ),
    );
  }
}
