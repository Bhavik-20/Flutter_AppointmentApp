import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class teacher_profile extends StatefulWidget {
  @override
  _teacher_profileState createState() => _teacher_profileState();
}

class _teacher_profileState extends State<teacher_profile> {


  final _formKey=GlobalKey<FormState>();
  String name="";
  String initials="";
  String room="";
  String email="";
  String password="";
  bool loading=false;

  String validate(String name, String initials, String room)
  {
    RegExp ofname=new RegExp(r'^[A-Za-z ]*$');
    RegExp ofini=new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroom=new RegExp(r'^[A-Za-z0-9\-]*$');
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (initials.isEmpty || !ofini.hasMatch(initials))
      return 'Invalid Initials';
    if (room.isEmpty || !ofroom.hasMatch(room))
      return 'Invalid Room Number';
    return 'valid';
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    Size size = MediaQuery.of(context).size;
    return StreamBuilder<Teacher>(
      stream: DatabaseService(uid: user.user_id).facultyData,
      builder: (context,snapshot){
        if(snapshot.hasData)
          {
            Teacher data=snapshot.data;

             return loading? Loading():Form(
              key: _formKey,
              child: Scaffold(
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
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child:TextFormField(
                                      initialValue: data.name ,
                                      enabled: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'playfair',
                                        ),
                                      onChanged: (value){
                                        setState(() => name=value);
                                      },
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        hintText: 'Full Name',
                                      )
                                    )
                                  ),
                                  Divider(
                                    color: Colors.deepPurple[100],
                                    thickness: 1,
                                  ),
                                  Container(
                                    height:50.0,
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child:TextFormField(
                                      initialValue:data.initials,
                                      enabled: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'playfair',
                                        ),
                                      onChanged: (value){
                                        setState(() => initials=value);
                                      },
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Initials',
                                      )
                                    )
                                  ),
                                  Divider(
                                    color: Colors.deepPurple[100],
                                    thickness: 1,
                                  ),
                                  Container(
                                    height:50.0,
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: TextFormField(
                                      initialValue: data.room,
                                      enabled: true,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'playfair',
                                    ),
                                      onChanged: (value){
                                        setState(() => room=value);
                                      },
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Room',
                                      ),
                                    )
                                  ),
                                  Divider(
                                    color: Colors.deepPurple[100],
                                    thickness: 1,
                                  ),
                                  Container(
                                    height:50.0,
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Expanded(
                                      child: TextFormField(
                                        initialValue: data.email,
                                        enabled: false,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'playfair',
                                        ),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'E-Mail',
                                        ),
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
                        press: () async {

                          name= name.isEmpty ? data.name : name;
                          initials= initials.isEmpty ? data.initials : initials;
                          room= room.isEmpty ? data.room : room;
                          email=data.email;
                          password=data.password;

                          print(name);
                          print(initials);
                          print(room);
                          print(email);
                          print(password);

                          String result=validate(name,initials,room);
                          if(result=='valid')
                            {
                              setState(() => loading=true);
                              await DatabaseService(uid: user.user_id).updateFacultyData(name, initials, room, email, password);
                              Fluttertoast.showToast(
                                backgroundColor: Colors.green,
                                msg: 'Successfully Updated Data',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                              );
                              Navigator.of(context).pushNamed('/tea_dash');
                            }
                          else
                            {
                              Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: result,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              );
                            }
                        },
                      ),
                      SizedBox(height: 30.0,),
                    ],
                  ),
                ),
              ),
            );
          }
        else
          {
            return Loading();
          }
      },
    );
  }

}
