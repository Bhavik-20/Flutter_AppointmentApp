import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/TimeTable.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';

class student_bookAppointment extends StatefulWidget {

  final Teacher teacher;
  student_bookAppointment({this.teacher});

  @override
  _student_bookAppointmentState createState() => _student_bookAppointmentState();
}
List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

class _student_bookAppointmentState extends State<student_bookAppointment> {
  int _currentStep = 0;
  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _dateTime;
  var day;
  var full;
  var purpose;
  var purpose_details;

  List days_of_week = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];


  List free_slots=[""];
  String time='';
  bool loading = false;
  // List tt = ['8:30-8:45','8:15-8:30','7:45-8:00'];

  Future<void> sendRequest(String name, String roll, String branch, String year,
      String st_mail, purpose,purpose_details, String time, date, String email2,String t_name,String initials,String room,String uid, String t_uid, String t_url, String s_url)
  async {
    try {
      await DatabaseService(uid: uid)
          .updateRequests(
          name,
          roll,
          branch,
          year,
          st_mail,
          purpose,
          purpose_details,
          time,
          date,
          widget.teacher.email,
          widget.teacher.name,
          widget.teacher.employee_code,
          widget.teacher.initials,
          widget.teacher.room,
          widget.teacher.teacher_id,
          widget.teacher.url,
          s_url
      );
    }
    catch (e) {
      print(e.toString());
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Size size = MediaQuery
        .of(context)
        .size;

    return StreamBuilder<Student>(
        stream: DatabaseService(uid: user.user_id).studentData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Student data = snapshot.data;
            return loading ? Loading() : Scaffold(
                backgroundColor: Colors.deepPurple[100],
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.of(context).pushNamed('/st_search_teacher');
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  backgroundColor: Colors.deepPurple[600],
                  title: Text('Book Appointment'),
                  centerTitle: true,
                  actions: [
                    Icon(Icons.access_time_sharp,
                      size: 30.0,)
                  ],
                ),
                body: Theme(
                  data: ThemeData(
                      accentColor: Colors.deepPurple[300],
                      primarySwatch: Colors.deepPurple,
                      colorScheme: ColorScheme.light(
                          primary: Colors.deepPurple[300]
                      )
                  ),
                  child: Stepper(
                    steps: _mySteps(data),
                    currentStep: this._currentStep,
                    onStepTapped: (step) {
                      setState(() {
                        this._currentStep = step;
                      });
                    },
                    onStepContinue: () async {
                        // setState(() {loading=true;});
                        if (this._currentStep < this._mySteps(data).length - 1)
                        {
                          setState(() {
                            // loading=false;
                            this._currentStep = this._currentStep + 1;
                          });
                        }
                        else {
                          if (time == "") {
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: 'Please Select Time',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            print("Select time");
                          }
                          if (full == null) {
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: 'Please Select Date',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            print("Select Date");
                          }
                          if (purpose == null || purpose.toString() == "") {
                            Fluttertoast.showToast(
                              backgroundColor: Colors.red,
                              msg: 'Please Enter Purpose',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            print("Please enter purpose");
                          }
                          if (time != "" && full != null &&
                              purpose != null && this._currentStep == 4) {
                            Fluttertoast.showToast(
                              backgroundColor: Colors.green,
                              msg: 'Request Sent Successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            print(purpose);
                            print("Completed");
                            setState(() =>loading=true);
                            await Future.delayed(const Duration(milliseconds: 3000));
                            await sendRequest(
                                data.name,
                                data.roll,
                                data.branch,
                                data.year,
                                data.email,
                                purpose,
                                purpose_details,
                                time,
                                full,
                                widget.teacher.email,
                                widget.teacher.name,
                                widget.teacher.initials,
                                widget.teacher.room,
                                user.user_id,
                                widget.teacher.teacher_id,
                                widget.teacher.url,
                                data.url,);
                            // loading = true;
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/st_dash');
                          }
                        }
                    },
                    onStepCancel: () {
                      setState(() {
                        if (this._currentStep > 0) {
                          this._currentStep = this._currentStep - 1;
                        }
                        else {
                          this._currentStep = 0;
                        }
                      });
                    },
                  ),
                )
            );
          }
          else {
            return Loading();
          }
        }
    );
  }

  List<Step> _mySteps(Student data) {
    List<Step> _steps = [
      Step(
        title: Text('Selected Teacher Info',
          style: TextStyle(
            fontSize: 18,
          ),),
        content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            // width: size.width*0.8,
            child: Column(
                children: [
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.deepPurple,),
                        SizedBox(width: 10.0,),
                        Text(
                          'Name: ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.teacher.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurple[100],
                    thickness: 1,
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.sort_by_alpha, color: Colors.deepPurple,),
                        SizedBox(width: 10.0,),
                        Text(
                          'Initials: ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                        Text(
                          widget.teacher.initials,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurple[100],
                    thickness: 1,
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.mail, color: Colors.deepPurple,),
                        SizedBox(width: 10.0,),
                        Text(
                          'Email: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.teacher.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurple[100],
                    thickness: 1,
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.deepPurple,),
                        SizedBox(width: 10.0,),
                        Text(
                          'Room No: ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                        Text(
                          widget.teacher.room,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            )
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Pick a Date',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        content: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[400],
                  border: Border.all(
                    color: Colors.deepPurple[400],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      firstDate: DateTime.now().add(Duration(days: 1)),
                      lastDate: DateTime.now().add(Duration(days: 7)),
                    ).then((date) {
                      setState(() {
                        // ---------- Extracting day and Date from DateTime date------------
                        day = days_of_week[date.weekday - 1];
                        if (day != 'Saturday' && day != 'Sunday') {
                          var formatter = new DateFormat('dd-MM-yyyy');
                          String formatted = formatter.format(date);
                          full = day + " : " + formatted;
                          print(full);
                        }
                        else {
                          Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            msg: 'Saturday and Sunday cannot be selected , Please select a Weekday.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                        //-------------Extracting ends here ------------------
                      });
                    });
                  }
              ),
            ),
            SizedBox(width: 15.0,),
            Text(full == null ? 'Select Date' : full.toString(),
              style: TextStyle(
                  fontFamily: 'playfair',
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Select Time',
          style: TextStyle(
            fontSize: 18,
          ),),
        content: Column(
          children: [
            Text(
                ' Select from the Available Time:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
            SizedBox(height: 10.0,),
        StreamBuilder<TimeTable>(
            stream: DatabaseService(uid: widget.teacher.teacher_id).tt_slots,
            builder: (context,snapshot){
              print("snap:"+snapshot.toString());
              if(snapshot.hasData){
                print("IF");
                if(day == "Monday") {
                 free_slots = snapshot.data.dynamic_mon;
                } else if(day == "Tuesday") {
                  free_slots = snapshot.data.dynamic_tue;
                }else if(day == "Wednesday") {
                  free_slots = snapshot.data.dynamic_wed;
                }else if(day == "Thursday") {
                  free_slots = snapshot.data.dynamic_thurs;
                }else if(day == "Friday") {
                  free_slots = snapshot.data.dynamic_fri;
                }
                print(free_slots);
                free_slots.sort((a,b)=>a.compareTo(b));

                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.deepPurple[600],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      value: time.isEmpty?free_slots.first:time,
                      onChanged: (value) {
                        setState(() {
                          time = value;
                        });
                      },
                      items: free_slots.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                    ),
                  );
              }
              else{
                return Center(child: Text("No free slots available"));
              }
            }
        ),

          ],
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Your Info',
          style: TextStyle(
            fontSize: 18,
          ),),
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          // color: Colors.white,
          // width: size.width*0.8,
          child: Column(
            children: [
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.deepPurple,),
                    SizedBox(width: 10.0,),
                    Text(
                      'Name: ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'playfair',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'playfair',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.deepPurple[100],
                thickness: 1,
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.perm_identity, color: Colors.deepPurple,),
                    SizedBox(width: 10.0,),
                    Text(
                      'Roll No.: ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'playfair',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data.roll,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'playfair',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.deepPurple[100],
                thickness: 1,
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.article_outlined, color: Colors.deepPurple,),
                    SizedBox(width: 10.0,),
                    Text(
                      'Branch : ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'playfair',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data.branch,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'playfair',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.deepPurple[100],
                thickness: 1,
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined, color: Colors.deepPurple,),
                    SizedBox(width: 10.0,),
                    Text(
                      'Year : ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'playfair',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data.year,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'playfair',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.deepPurple[100],
                thickness: 1,
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Icon(Icons.mail, color: Colors.deepPurple,),
                    SizedBox(width: 10.0,),
                    Text(
                      'Email: ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'playfair',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        data.email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'playfair',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: Text('Purpose Of Meet',
          style: TextStyle(
            fontSize: 18,
          ),),
        content: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  onChanged: (value) {
                    setState(() => purpose = value);
                  },
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'playfair',
                      fontWeight: FontWeight.bold
                  ),
                  maxLength: 20,
                  maxLengthEnforced: true,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    hintText: 'Purpose in short',
                    border: InputBorder.none,
                  ),
                ),
              ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              onChanged: (value) {
                setState(() => purpose_details = value);
              },
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'playfair',
                  fontWeight: FontWeight.bold
              ),
              maxLines: 5,
              autocorrect: false,
              autofocus: false,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                hintText: 'Explain purpose (Optional)',
                border: InputBorder.none,
              ),
            ),
            ),
          ],
        ),
        isActive: _currentStep >= 4,
      ),
    ];
    return _steps;
  }
}
