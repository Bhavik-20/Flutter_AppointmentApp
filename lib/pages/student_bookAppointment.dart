import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:intl/intl.dart';

class student_bookAppointment extends StatefulWidget {
  @override
  _student_bookAppointmentState createState() => _student_bookAppointmentState();
}

class _student_bookAppointmentState extends State<student_bookAppointment> {
  int _currentStep=0;
  DateTime _dateTime;
  var day;
  var full;
  List days_of_week=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  final List<String> free_slots=["02:30 - 02:45 pm", "03:00 - 03:15 pm"];
  String time="02:30 - 02:45 pm";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
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
          steps: _mySteps(),
          currentStep: this._currentStep,
          onStepTapped: (step){
            setState(() {
              this._currentStep=step;
            });
          },
          onStepContinue: (){
            setState(() {
              if(this._currentStep<this._mySteps().length-1)
              {
                this._currentStep=this._currentStep+1;
              }
              else
              {
                //To check if everything is completed
                print("Completed");
              }
            });
          },
          onStepCancel: (){
            setState(() {
              if(this._currentStep>0)
                {
                  this._currentStep=this._currentStep-1;
                }
              else
                {
                  this._currentStep=0;
                }
            });
          },
        ),
      )
    );
  }

  List<Step> _mySteps(){
    List<Step> _steps=[
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
                    height:50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'playfair',
                          fontWeight: FontWeight.bold
                      ),
                      enabled: false,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'playfair',
                          fontWeight: FontWeight.bold
                      ),
                      enabled: false,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'playfair',
                          fontWeight: FontWeight.bold
                      ),
                      enabled: false,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'playfair',
                          fontWeight: FontWeight.bold
                      ),
                      enabled: false,
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
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Pick a Date',
          style: TextStyle(
            fontSize: 18,
          ),),
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
                    firstDate:  DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime.now().add(Duration(days: 7)),
                  ).then((date) {
                    setState(() {
                      // ---------- Extracting day and Date from DateTime date------------
                      day=days_of_week[date.weekday-1];
                      var formatter = new DateFormat('dd-MM-yyyy');
                      String formatted = formatter.format(date);
                      full=day+" : "+formatted;
                      print(full);
                      //-------------Extracting ends here ------------------
                    });
                  });
                }
                ),
            ),
            SizedBox(width: 15.0,),
            Text(full==null?'Select Date':full.toString(),
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

            Text('-> The dropdown consists of free slots for the faculty on selected date <-',),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  border: Border.all(
                    color: Colors.deepPurple[600],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: DropdownButton<String>(
                dropdownColor: Colors.deepPurple[100],
                icon: Icon(Icons.arrow_drop_down),
                value: time,
                onChanged: (value){
                  setState(() {
                    time=value;
                  });
                },
                items: free_slots.map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            )
          ],
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Your  Info',
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
                height:50.0,
                child: TextField(
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'playfair',
                    fontWeight: FontWeight.bold
                  ),
                  enabled: false,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    labelText: 'Name',
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
                  enabled: false,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    labelText: 'Roll number',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(
                color: Colors.deepPurple[100],
                thickness: 1,
              ),
              Container(
                height:40.0,
                child: TextField(
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'playfair',
                      fontWeight: FontWeight.bold
                  ),
                  enabled: false,
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
                thickness: 1.3,
              ),
              Container(
                height:40.0,
                child: TextField(
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'playfair',
                      fontWeight: FontWeight.bold
                  ),
                  enabled: false,
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
                height:40.0,
                child: TextField(
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'playfair',
                      fontWeight: FontWeight.bold
                  ),
                  enabled: false,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    labelText: 'Somaiya Email',
                    border: InputBorder.none,
                  ),
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
          child: Container(
            child: TextField(
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
                hintText: 'Purpose of Meet',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        isActive: _currentStep >= 4,
      ),
    ];
    return _steps;
  }
}
