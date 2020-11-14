import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/services/constants.dart';
import 'package:flutter_appointment_app/services/rounded_button.dart';
import 'package:flutter_appointment_app/services/rounded_input_field.dart';
import 'package:flutter_appointment_app/services/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

void main(){
  runApp(dateSelect());
}

class dateSelect extends StatefulWidget {
  @override
  _dateSelectState createState() => _dateSelectState();
}

class _dateSelectState extends State<dateSelect> {
  DateTime _dateTime;
  var day;
  var full;
  List days_of_week=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
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
            ),
          ),
          backgroundColor: Colors.deepPurple[600],
          title: Text('Select Date and Time'),
          centerTitle: true,
          actions: [
            Icon(Icons.access_time_sharp)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0,),
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
                                labelText: 'Email',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ]
                    )
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  SizedBox(width: 50.0,),
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10.0,),
                      RaisedButton(
                          child: Text('Pick a Date:'),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now().add(Duration(days: 1)),
                              firstDate:  DateTime.now().add(Duration(days: 1)),
                              lastDate: DateTime.now().add(Duration(days: 7)),
                            ).then((date) {
                              setState(() {
                                day=days_of_week[date.weekday-1];
                                var formatter = new DateFormat('dd-MM-yyyy');
                                String formatted = formatter.format(date);
                                full=day+" : "+formatted;
                                print(full);
                              });
                            });
                          }),
                    ],
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

            ],
          ),
        )
    );
  }
}
