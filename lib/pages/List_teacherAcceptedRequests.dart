import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/pages/teacher_request_status.dart';
import 'package:provider/provider.dart';

class listofAcceptedRequests extends StatefulWidget {
  @override
  _listofAcceptedRequestsState createState() => _listofAcceptedRequestsState();
}

class _listofAcceptedRequestsState extends State<listofAcceptedRequests> {
  @override
  Widget build(BuildContext context) {
    final accepted=Provider.of<List<Request>>(context)??[];

    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Accepted Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                        backgroundImage: AssetImage('images/role_student.jpg'),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(accepted[index].student_name),
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
