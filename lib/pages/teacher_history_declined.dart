import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/teacher_request_status.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class teacher_history_declined extends StatefulWidget {
  @override
  _teacher_history_declinedState createState() => _teacher_history_declinedState();
}

class _teacher_history_declinedState extends State<teacher_history_declined> {
  @override
  Widget build(BuildContext context) {

    final rejected=Provider.of<List<Request>>(context)??[];

    rejected.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'a'));

    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Rejected Requests",
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
              itemCount: rejected.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top:8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListTile(
                      onTap: (){
                        print(rejected[index].date);
                        print(rejected[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> teacher_request_status(request:rejected[index])));
                      },
                      leading: CircleAvatar(
                        child:  ClipOval(
                          child: new SizedBox(
                            height: 180,
                            width:180,
                            child:(rejected[index].s_url == '' || rejected[index].s_url == null) ? Image.asset('images/role_student.jpg',
                              fit: BoxFit.cover,) : Image.network(rejected[index].s_url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        radius: 25.0,
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(rejected[index].student_name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),),
                      subtitle: Text(rejected[index].date),
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
