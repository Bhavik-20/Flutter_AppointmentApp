import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/student_request_status.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class listofnewStudentRequests extends StatefulWidget {
  @override
  _listofnewStudentRequestsState createState() => _listofnewStudentRequestsState();
}

class _listofnewStudentRequestsState extends State<listofnewStudentRequests> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final requests=Provider.of<List<Request>>(context)??[];
    requests.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'d'));
    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Pending Requests",
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> student_request_status(request:requests[index],page: "new",)));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(requests[index].t_url == '' || requests[index].t_url == null ) ? Image.asset('images/profile_faculty.png',
                              fit: BoxFit.cover,) : Image.network(requests[index].t_url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(requests[index].teacher_name,
                        style: TextStyle(
                          fontSize: size.height * 0.023,
                        ),
                      ),
                      subtitle: Text(requests[index].date,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                        ),
                      ),
                      trailing: Text(requests[index].teacher_ini,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                        ),
                      ) ,
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
