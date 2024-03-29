import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class listofStudentAcceptedRequests extends StatefulWidget {
  @override
  _listofStudentAcceptedRequestsState createState() => _listofStudentAcceptedRequestsState();
}

class _listofStudentAcceptedRequestsState extends State<listofStudentAcceptedRequests> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accepted=Provider.of<List<Request>>(context)??[];
    accepted.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'d'));
    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Accepted Requests",
              style: GoogleFonts.merriweather(
                fontSize: size.height * 0.029,
                // fontWeight: FontWeight.bold,
                color: Colors.deepPurple[500],
              ),)
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> student_request_status(request:accepted[index],page: "accepted",)));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(accepted[index].t_url == '' || accepted[index].t_url == null) ? Image.asset('images/profile_faculty.png',
                              fit: BoxFit.cover,) : Image.network(accepted[index].t_url,
                              fit: BoxFit.cover,
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
