import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/pages/teacher_request_status.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class listofAcceptedRequests extends StatefulWidget {
  @override
  _listofAcceptedRequestsState createState() => _listofAcceptedRequestsState();
}

class _listofAcceptedRequestsState extends State<listofAcceptedRequests> {
  @override
  Widget build(BuildContext context) {
    final accepted=Provider.of<List<Request>>(context)??[];
    List<Request> limited_req=[];
    for(int i=0;i<accepted.length;i++)
    {
      String req_date= accepted[i].date.split(":").last.trim();
      DateTime req_date2=DateTime.parse(req_date);
      DateTime now = new DateTime.now();
      DateTime today_date = new DateTime(now.year, now.month, now.day);
      if(req_date2.compareTo(today_date)>=0)
      {
        limited_req.add(accepted[i]);
      }
    }
    limited_req.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'a'));
    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Accepted Requests",
              style: GoogleFonts.merriweather(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: Colors.deepPurple[500],
              ),),
          ),
          color: Colors.deepPurple[100],
          height: 50,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: limited_req.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top:8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListTile(
                      onTap: (){
                        print(limited_req[index].date);
                        print(limited_req[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> teacher_request_status(request:limited_req[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(limited_req[index].s_url == '' || limited_req[index].s_url == null) ? Image.asset('images/role_student.jpg',
                              fit: BoxFit.fill,) : Image.network(limited_req[index].s_url,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(limited_req[index].student_name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),),
                      subtitle: Text(limited_req[index].date),
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
