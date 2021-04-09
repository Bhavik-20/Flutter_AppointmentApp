import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/pages/teacher_request_status.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class listofStudentDeclinedRequests extends StatefulWidget {
  @override
  _listofStudentDeclinedRequestsState createState() => _listofStudentDeclinedRequestsState();
}

class _listofStudentDeclinedRequestsState extends State<listofStudentDeclinedRequests> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accepted=Provider.of<List<Request>>(context)??[];
    accepted.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'d'));
    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Declined Requests",
              style: GoogleFonts.merriweather(
                fontSize: size.height * 0.029,
                // fontWeight: FontWeight.bold,
                color: Colors.deepPurple[500],
              ),),
          ),
          color: Colors.deepPurple[100],
          height: size.height * 0.05,
          margin: new EdgeInsets.fromLTRB(0,10,0,0),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: accepted.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top:8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListTile(
                      onTap: (){
                        print(accepted[index].date);
                        print(accepted[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> student_request_status(request:accepted[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(accepted[index].t_url == '' || accepted[index].t_url == null) ? Image.asset('images/role_teacher.jpg',
                              fit: BoxFit.fill,) : Image.network(accepted[index].t_url,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(accepted[index].teacher_name,
                        style: TextStyle(
                          fontSize: size.height * 0.023,
                        ),
                      ),
                      subtitle: Text(accepted[index].date,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                        ),
                      ),
                      trailing: Text(accepted[index].teacher_ini,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}
