import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main()
{
  runApp(teacher_dashboard());
}

class teacher_dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[600],
          title: Text('Teacher Dashboard'),
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
                      onPressed: (){},
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
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          SizedBox(width: 15.0),
                          Text('Schedule',
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
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 15.0),
                          Text('History',
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
                      onPressed: (){},
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
                    ),
                  ],
                )
              ],
            )
        ),

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.deepPurple[600],
          height: 50,
          animationDuration: Duration(milliseconds: 200,),
          animationCurve: Curves.bounceInOut ,
          items: <Widget>[
            Icon(Icons.calendar_today_outlined, size: 25),
            Icon(Icons.playlist_add_check, size: 30),
            Icon(Icons.cancel_presentation_outlined, size: 25),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
      ),
    );
  }
}
