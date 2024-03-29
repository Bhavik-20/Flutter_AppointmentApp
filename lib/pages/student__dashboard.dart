import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student_accepted_requests.dart';
import 'package:flutter_appointment_app/pages/student_declined_requests.dart';
import 'package:flutter_appointment_app/pages/student_new_requests.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';


class student_dashboard extends StatefulWidget {

  @override
  _student_dashboardState createState() => _student_dashboardState();
}


class _student_dashboardState extends State<student_dashboard> {



  final AuthService _auth=AuthService();


  bool loading=false;
  int _selectedIndex = 0;
   List<Widget> _widgetOptions = <Widget>[
     student_new_requests(),
     student_accepted_requests(),
     student_declined_requests(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    return user==null ? role() : StreamBuilder<Student>(
        stream: DatabaseService(uid: user.user_id).studentData,
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            Student data = snapshot.data;
            return  loading? Loading() : WillPopScope(
              onWillPop: () async => false,
              child: MaterialApp(
                home: Scaffold(
                  backgroundColor: Colors.deepPurple[100],
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple[600],
                    title: Text('Student Dashboard',
                      style:TextStyle(
                      fontSize: size.width*0.047,
                    ) ,),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.help_outline),
                        tooltip: 'Help',
                        onPressed: (){
                          Navigator.of(context).pushNamed('/stu_tips');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        tooltip: 'Sign Out',
                        onPressed: () async {
                          setState(() => loading=true);
                          await Future.delayed(const Duration(milliseconds: 3000));
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          prefs.remove("role");
                          prefs.remove("id_user");
                          await _auth.signOut();
                          // Navigator.of(context).pushNamed('/');
                        },
                      ),
                    ],
                    leading:
                    IconButton(
                      icon: Icon(Icons.account_circle_rounded),
                      tooltip: 'Profile',
                      onPressed: (){
                        Navigator.of(context).pushNamed('/st_profile');
                      },
                    ),

                  ),

                  body:  Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('MeetUp',style: TextStyle(fontSize: 11)),
                        Image.asset('images/tap.png',height:25),
                      ],
                    ),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/st_search_teacher');
                  },
                    backgroundColor: Colors.deepPurple[600],
                    mini: false,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.pending_actions,
                          size: 25,
                        ),
                        label: 'Pending',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.playlist_add_check, size: 35,),
                        label: 'Accepted',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.remove_circle, size: 30,),
                        label: 'Rejected',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.deepPurple[900],
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            );
          }
          else
          {
            return Loading();
          }
        }
    );
  }
}
