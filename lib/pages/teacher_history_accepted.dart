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

class teacher_history_accepted extends StatefulWidget {
  @override
  _teacher_history_acceptedState createState() => _teacher_history_acceptedState();
}

class _teacher_history_acceptedState extends State<teacher_history_accepted> {
  @override
  Widget build(BuildContext context) {
    final accepted=Provider.of<List<Request>>(context)??[];
    accepted.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'d'));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> teacher_request_status(request:accepted[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(accepted[index].s_url == '' || accepted[index].s_url == null) ? Image.asset('images/role_student.jpg',
                              fit: BoxFit.cover,) : Image.network(accepted[index].s_url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(accepted[index].student_name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),),
                      subtitle: Text(accepted[index].date),
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
