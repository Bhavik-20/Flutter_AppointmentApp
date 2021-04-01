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
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'playfair',
                  color: Colors.black,
                ),),
            ),
            Center(
                child:  Column(
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
                            fontSize: 20.0,
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
                               hintText: widget.request.purpose_details,
                               hintStyle: TextStyle(
                                 color: Colors.black,
                               ),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                       SizedBox(height: 15.0,),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                         child: Text( 'Request Status:',
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
                             hintText: widget.request.status,
                             hintStyle: TextStyle(
                               color: Colors.black,
                             ),
                             border: InputBorder.none,
                           ),
                         ),
                       ),

                ],
              ),
              ),
          SizedBox(height: 30.0,),

          ],
        ),
      ),
    );
  }
}
