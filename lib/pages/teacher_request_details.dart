import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/EmailSender.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
  String why_rej="";

  String check_whyrej(String reason) {
    if(reason.isEmpty)
      return 'invalid';
    return 'valid';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    DateTime now = new DateTime.now();
    DateTime today_date = new DateTime(now.year, now.month, now.day);
    DateTime req_date = DateTime.parse(widget.request.date.split(":").last.trim());

    bool show_options = req_date.compareTo(today_date)<0 ? false : true;

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
                    Navigator.pop(context);
                    // Navigator.of(context).pushNamed('/tea_dash');
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
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: 'playfair',
                          color: Colors.black,
                        ),),
                    ),
                    Center(
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                width: size.width*0.8,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'playfair',
                                    color: Colors.black,
                                  ),
                                  enabled: false,
                                  maxLines: 1,
                                  autocorrect: false,
                                  autofocus: false,
                                  cursorColor: Colors.black,
                                  decoration: new InputDecoration(
                                    hintText: widget.request.purpose,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if(widget.request.purpose_details != null)
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text( 'Purpose Explained:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'playfair',
                                      color: Colors.black,
                                    ),),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  width: size.width*0.8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'playfair',
                                      color: Colors.black,
                                    ),
                                    enabled: false,
                                    maxLines: 5,
                                    autocorrect: false,
                                    autofocus: false,
                                    cursorColor: Colors.black,
                                    decoration: new InputDecoration(
                                      hintText: widget.request.purpose_details,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: show_options ? Text( 'Reason for rejecting the appointment:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  fontFamily: 'playfair',
                                  color: Colors.black,
                                ),) :
                                Text( 'The Request Date has passed.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  fontFamily: 'playfair',
                                  color: Colors.black,
                                ),),
                            ),
                            if(show_options)
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: size.width*0.8,
                              height: size.height*0.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'playfair',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                // enabled: true,
                                maxLines: 5,
                                autocorrect: false,
                                autofocus: false,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                  hintText: 'Type here only if rejecting request..',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value){
                                  setState(() {
                                    why_rej=value;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 30.0,),
                    if(show_options)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () async{
                            setState(() => loading=true);
                            print('accepted');

                            await DatabaseService().deleteRequests(widget.request.request_id);
                            await DatabaseService().acceptRequests(
                                widget.request.request_id,
                                widget.request.student_id,
                                widget.request.student_name,
                                widget.request.student_rollno,
                                widget.request.student_branch,
                                widget.request.student_year,
                                widget.request.student_mail,
                                widget.request.purpose,
                                widget.request.purpose_details,
                                widget.request.time,
                                widget.request.date,
                                widget.request.teacher_mail,
                                widget.request.teacher_name,
                                widget.request.employee_code,
                                widget.request.teacher_ini,
                                widget.request.teacher_room,
                                widget.request.request_id,
                                widget.request.teacher_id,
                                widget.request.t_url,
                                widget.request.s_url);

                            await EmailSender().sendMailToStudent(
                                widget.request.student_mail,
                                widget.request.teacher_name,
                                widget.request.teacher_mail,
                                widget.request.teacher_ini,
                                widget.request.teacher_room,
                                widget.request.purpose,
                                widget.request.date,
                                widget.request.time,
                                "Accepted");

                            Fluttertoast.showToast(
                              backgroundColor: Colors.green,
                              msg: 'The request is accepted',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            Navigator.pop(context);
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
                          onPressed: () async {
                            String status = check_whyrej(why_rej);
                            if (status.trim() == 'valid')
                            {
                              // appending reason for rejection to status
                              status="Rejected.\n"+ why_rej;

                              setState(() => loading=true);
                              print(why_rej);
                              print('rejected');
                              await DatabaseService().deleteRequests(
                                  widget.request.request_id);
                              await DatabaseService(uid: widget.request.teacher_id).addSlot(widget.request.time, widget.request.date);
                              await DatabaseService().declineRequests(
                                  widget.request.request_id,
                                  widget.request.student_id,
                                  widget.request.student_name,
                                  widget.request.student_rollno,
                                  widget.request.student_branch,
                                  widget.request.student_year,
                                  widget.request.student_mail,
                                  widget.request.purpose,
                                  widget.request.purpose_details,
                                  widget.request.time,
                                  widget.request.date,
                                  status,
                                  widget.request.teacher_mail,
                                  widget.request.teacher_name,
                                  widget.request.employee_code,
                                  widget.request.teacher_ini,
                                  widget.request.teacher_room,
                                  widget.request.request_id,
                                  widget.request.teacher_id,
                                  widget.request.t_url,
                                  widget.request.s_url);
                              await EmailSender().sendMailToStudent(
                                  widget.request.student_mail,
                                  widget.request.teacher_name,
                                  widget.request.teacher_mail,
                                  widget.request.teacher_ini,
                                  widget.request.teacher_room,
                                  widget.request.purpose,
                                  widget.request.date,
                                  widget.request.time,
                                  status);

                              Fluttertoast.showToast(
                                backgroundColor: Colors.red,
                                msg: 'The request is rejected',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              Navigator.pop(context);
                            }
                            else{
                              Fluttertoast.showToast(
                                backgroundColor: Colors.red,
                                msg: 'Please Enter Reason For Rejecting Request',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0,),
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
