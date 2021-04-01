import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:provider/provider.dart';

class listofnewStudentRequests extends StatefulWidget {
  @override
  _listofnewStudentRequestsState createState() => _listofnewStudentRequestsState();
}

class _listofnewStudentRequestsState extends State<listofnewStudentRequests> {
  @override
  Widget build(BuildContext context) {
    final requests=Provider.of<List<Request>>(context)??[];
    requests.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'a'));
    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Pending Requests",
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
              itemCount: requests.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top:8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListTile(
                      onTap: (){
                        print(requests[index].date);
                        print(requests[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> student_request_status(request:requests[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(requests[index].t_url == '' || requests[index].t_url == null ) ? Image.asset('images/role_teacher.jpg',
                              fit: BoxFit.fill,) : Image.network(requests[index].t_url,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(requests[index].teacher_name),
                      subtitle: Text(requests[index].date),
                      trailing: Text(requests[index].teacher_ini) ,
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
