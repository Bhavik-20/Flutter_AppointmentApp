import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(student_request_status());
}

class student_request_status extends StatefulWidget {
  @override
  _student_request_statusState createState() => _student_request_statusState();
}

class _student_request_statusState extends State<student_request_status> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title:Text('Request Details'),
        leading: Icon(Icons.arrow_back),
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
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'playfair'
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
                            fontSize: 20.0,
                            fontFamily: 'playfair'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Initials',
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
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'playfair'
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
                      thickness: 1.3,
                    ),
                    Container(
                      height:40.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'playfair'
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
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:40.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'playfair'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Date',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[100],
                      thickness: 1,
                    ),
                    Container(
                      height:42.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'playfair'
                        ),
                        enabled: false,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: 'Time',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    child: TextField(
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'playfair'
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
                    child: TextField(
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'playfair'
                      ),
                      autocorrect: false,
                      autofocus: false,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        hintText: 'Approved',
                        labelText: 'Request Status',
                        border: InputBorder.none,
                      ),
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