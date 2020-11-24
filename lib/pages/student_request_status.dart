import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';

void main()
{
  runApp(student_request_status());
}

class student_request_status extends StatefulWidget {
  @override
  _student_request_statusState createState() => _student_request_statusState();
  final Request request;
  student_request_status({this.request});
}

class _student_request_statusState extends State<student_request_status> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title:Text('Request Details'),
        leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/st_dash');
            },
        ),
        backgroundColor: Colors.deepPurple[600],
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
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                // color: Colors.white,
                width: size.width*0.8,
                child: Column(
                  children: [
                    Container(
                      height:50.0,
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
                              widget.request.teacher_name,
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
                      height:50.0,
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
                          Expanded(
                            child: Text(
                              widget.request.teacher_ini,
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
                      height:50.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.deepPurple,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Room No.: ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.request.teacher_room,
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
                      thickness: 1.3,
                    ),
                    Container(
                      height:50.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(Icons.mail, color: Colors.deepPurple,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Mail: ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.request.teacher_mail,
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
                      height:40.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(Icons.today, color: Colors.deepPurple,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Date : ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.request.date,
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
                      height:40.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(Icons.schedule, color: Colors.deepPurple,),
                          SizedBox(width: 10.0,),
                          Text(
                            'Time : ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'playfair',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.request.time,
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
            ),
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text( 'Purpose of Meet:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'playfair',
                  color: Colors.black,
                ),),
            ),
            Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  // color: Colors.white,
                  width: size.width*0.8,
                  child: Container(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'playfair',
                        color: Colors.black,
                      ),
                      enabled: false,
                      maxLines: 5,
                      autocorrect: false,
                      autofocus: false,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        hintText: widget.request.purpose,
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
            ),
            SizedBox(height: 30.0,),
            Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  // color: Colors.white,
                  width: size.width*0.8,
                  child: Container(
                    height:40.0,
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Request Status : ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'playfair',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.request.status,
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
                )
            ),
            SizedBox(height: 30.0,),
            Container(
              width: 200 ,
              child: RaisedButton(
                onPressed: () => {},
                color: Colors.red,
                hoverColor: Colors.red[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
                elevation: 5,
                padding: EdgeInsets.fromLTRB(20.0,10,20,10),
                child: Row( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.cancel , color: Colors.white,),
                    SizedBox(width: 10.0,),
                    Text("Cancel Request",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}
