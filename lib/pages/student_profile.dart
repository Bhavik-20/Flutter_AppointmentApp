import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class student_profile extends StatefulWidget {
  @override
  _student_profileState createState() => _student_profileState();
}

class _student_profileState  extends State<student_profile> {

  final _formKey=GlobalKey<FormState>();

  String name="";
  String roll="";
  String branch="";
  String year="";
  String email="";
  String password="";
  bool loading=false;
  int b=0;
  int y=0;
  List _branch= ['Computer','Information Technology','Mechanical','Electronics','EXTC'];
  List _year=['FY','SY','TY','LY'];

  String validate(String name, String rollno, String branch, String year)
  {
    RegExp ofname=new RegExp(r'^[A-Za-z ]*$');
    RegExp ofini=new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroll=new RegExp(r'^[0-9\-]*$');
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (rollno.isEmpty || !ofroll.hasMatch(rollno))
      return 'Invalid roll number';
    if (branch.isEmpty)
      return 'Select Branch';
    if (year.isEmpty)
      return 'Select Year';
    return 'valid';
  }

  @override
  Widget build(BuildContext context)
  {
    final user = Provider.of<User>(context);

    Size size = MediaQuery.of(context).size;

    return StreamBuilder<Student>(
      stream: DatabaseService(uid: user.user_id).studentData,
      builder: (context,snapshot) {
      if(snapshot.hasData)
      {
        Student data=snapshot.data;
        return loading? Loading():Form(
          key: _formKey,
          child: Scaffold(
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
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
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
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple[100],
                                thickness: 1,
                              ),
                              Container(
                                height:50.0,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                    initialValue: data.roll ,
                                    enabled: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'playfair',
                                    ),
                                    onChanged: (value){
                                      setState(() => roll=value);
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Roll Number',
                                    )
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple[100],
                                thickness: 1,
                              ),
                              Container(
                                height:50.0,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child:TextFormField(
                                    initialValue: data.branch ,
                                    enabled: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'playfair',
                                    ),
                                    onChanged: (value){
                                      setState(() => branch=value);
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Branch',
                                    )
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple[100],
                                thickness: 1,
                              ),
                              Container(
                                height:50.0,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                    initialValue: data.year ,
                                    enabled: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'playfair',
                                    ),
                                    onChanged: (value){
                                      setState(() => year=value);
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Year',
                                    )
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple[100],
                                thickness: 1,
                              ),
                              Container(
                                height:50.0,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                            ]
                        )
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  RoundedButton(
                    text: 'Save Changes',
                    press: () async {

                      name= name.isEmpty ? data.name : name;
                      roll= roll.isEmpty ? data.roll : roll;
                      branch= branch.isEmpty ? data.branch : branch;
                      year= year.isEmpty ? data.year : year;
                      email= data.email;
                      password=data.password;

                      print(name);
                      print(roll);
                      print(branch);
                      print(year);
                      print(email);
                      print(password);

                      if(_branch.contains(branch))
                      {
                        b = 1;
                      }
                      else {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            msg: 'Please enter a valid branch.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM, );
                      }

                      if(_year.contains(year))
                      {
                        y = 1;
                      }
                      else {
                        Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          msg: 'Please enter a valid year.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM, );
                      }

                      String result=validate(name,roll,branch,year);
                      if(result=='valid' && b==1 && y==1)
                      {
                        setState(() => loading=true);
                        await DatabaseService(uid: user.user_id).updateStudentData(name, roll,branch,year,email,password);
                        Fluttertoast.showToast(
                          backgroundColor: Colors.green,
                          msg: 'Successfully Updated Data',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.of(context).pushNamed('/st_dash');
                      }
                      else if(result !='valid')
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
    }
    );
  }
}
