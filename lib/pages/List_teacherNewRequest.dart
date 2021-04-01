import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:provider/provider.dart';

class listofnewFacultyRequests extends StatefulWidget {
  @override
  _listofnewFacultyRequestsState createState() => _listofnewFacultyRequestsState();
}

class _listofnewFacultyRequestsState extends State<listofnewFacultyRequests> {
  List _branch_ini=['COMP','IT','MECH','ETRX','EXTC'];
  List _branch= ['Computer','Information Technology','Mechanical','Electronics','EXTC'];
  int branch_index;
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

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> teacher_request_details(request:requests[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(requests[index].s_url == '' || requests[index].s_url == null) ? Image.asset('images/role_student.jpg',
                              fit: BoxFit.fill,) : Image.network(requests[index].s_url,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(requests[index].student_name ,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),),
                      isThreeLine: true,
                      subtitle: Text(
                          'Purpose : '+ requests[index].purpose + '\n' + requests[index].date,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: branch(requests[index].student_branch),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  branch(String student_branch) {
    branch_index = _branch.indexOf(student_branch);
    return Text(_branch_ini[branch_index] ,style: TextStyle(
      fontSize: 18,
    ),);
  }


}


