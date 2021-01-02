import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/teacher_declined_requests.dart';
import 'package:flutter_appointment_app/pages/teacher_new_requests.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_appointment_app/pages/teacher_accepted_requests.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(teacher_dashboard());
}

class teacher_dashboard extends StatefulWidget {
  @override
  _teacher_dashboardState createState() => _teacher_dashboardState();
}

class _teacher_dashboardState extends State<teacher_dashboard> {

  int _selectedIndex = 0;
  bool loading=false;
  final AuthService _auth=AuthService();

  List<Widget> _widgetOptions = <Widget>[
    teacher_new_requests(),
    teacher_accepted_requests(),
    teacher_declined_requests(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    Size size = MediaQuery
        .of(context)
        .size;
    return StreamBuilder<Teacher>(
        stream: DatabaseService(uid: user.user_id).facultyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Teacher data = snapshot.data;
            return loading? Loading() : WillPopScope(
              onWillPop: () async => false,
              child: MaterialApp(
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
                                    child:  ClipOval(
                                      child: new SizedBox(
                                        height: 180,
                                        width:180,
                                        child: (data.url == '' || data.url == null) ? Image.asset('images/role_student.jpg',
                                          fit: BoxFit.fill,) : Image.network(data.url, fit: BoxFit.fill,),
                                      ),
                                    ),
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
                                  Navigator.of(context).pushNamed('/tea_profile');
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
                                onPressed: (){},
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today_sharp),
                                    SizedBox(width: 15.0),
                                    Text('Time Table',
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
                                  Navigator.of(context).pushNamed('/tea_history');
                                },
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
                                onPressed: () async {
                                  setState(() => loading=true);
                                  await Future.delayed(const Duration(milliseconds: 3000));
                                  await _auth.signOut();
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
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                  body: Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                  bottomNavigationBar: CurvedNavigationBar(
                    backgroundColor: Colors.deepPurple[600],
                    height: 50,
                    animationDuration: Duration(milliseconds: 200,),
                    animationCurve: Curves.bounceInOut ,
                    items: <Widget>[
                      Icon(Icons.pending_actions, size: 25),
                      Icon(Icons.playlist_add_check, size: 30),
                      Icon(Icons.remove_circle, size: 25),
                    ],
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            );
          }
          else {
            return Loading();
          }
        });
  }
}