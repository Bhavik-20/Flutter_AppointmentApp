import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(teacher_request_details());
}

class teacher_request_details extends StatefulWidget {

  final Request request;
  teacher_request_details({this.request});


  @override
  _teacher_request_detailsState createState() => _teacher_request_detailsState();
}

class _teacher_request_detailsState extends State<teacher_request_details> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    return StreamBuilder<Teacher>(
        stream: DatabaseService(uid: user.user_id).facultyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Teacher data = snapshot.data;
            return loading ? Loading() : Scaffold(
              backgroundColor: Colors.deepPurple[50],
              appBar: AppBar(
                title:Text('Request Details'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/tea_dash');
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
                                      widget.request.student_name,
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
                                      widget.request.student_rollno,
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
                                      widget.request.student_branch,
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
                              height:40.0,
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
                                      widget.request.student_year,
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
                                      widget.request.student_mail,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () async{
                            print('accepted');
                            await DatabaseService().deleteRequests(widget.request.request_id);
                            await DatabaseService().acceptRequests(
                                widget.request.request_id,
                                widget.request.student_name,
                                widget.request.student_rollno,
                                widget.request.student_branch,
                                widget.request.student_year,
                                widget.request.student_mail,
                                widget.request.purpose,
                                widget.request.time,
                                widget.request.date,
                                widget.request.teacher_mail,
                                widget.request.request_id);
                            print(widget.request.request_id);
                          },
                          color: Colors.green,
                          hoverColor: Colors.green[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          elevation: 5,
                          padding: EdgeInsets.fromLTRB(20.0,10,20,10),
                          child: Row( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(Icons.check_circle , color: Colors.white,),
                              SizedBox(width: 10.0,),
                              Text("Accept",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),)
                            ],
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        RaisedButton(
                          onPressed: () async{
                            print('rejected');
                            await DatabaseService().deleteRequests(widget.request.request_id);
                            await DatabaseService().declineRequests(
                                widget.request.request_id,
                                widget.request.student_id,
                                widget.request.student_name,
                                widget.request.student_rollno,
                                widget.request.student_branch,
                                widget.request.student_year,
                                widget.request.student_mail,
                                widget.request.purpose,
                                widget.request.time,
                                widget.request.date,
                                widget.request.teacher_mail,
                                widget.request.request_id);
                            print(widget.request.request_id);

                          },

                          color: Colors.red,
                          hoverColor: Colors.red[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          elevation: 5,
                          padding: EdgeInsets.fromLTRB(20.0,10,20,10),
                          child: Row( // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(Icons.cancel , color: Colors.white,),
                              SizedBox(width: 10.0,),
                              Text("Reject",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
            );
          }
          else {
            return Loading();
          }
        }
    );
  }
}
