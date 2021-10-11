import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/pages/teacher_request_details.dart';
import 'package:flutter_appointment_app/services/SortRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class teacher_history_new extends StatefulWidget {
  @override
  _teacher_history_newState createState() => _teacher_history_newState();
}

class _teacher_history_newState extends State<teacher_history_new> {
  List _branch_ini=['COMP','IT','MECH','ETRX','EXTC'];
  List _branch= ['Computer','Information Technology','Mechanical','Electronics','EXTC'];
  int branch_index;
  @override
  Widget build(BuildContext context) {
    final requests=Provider.of<List<Request>>(context)??[];

    requests.sort((a,b)=> SortRequest().check(a.date,b.date,a.time,b.time,'d'));

    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Pending Requests",
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
                              fit: BoxFit.cover,) : Image.network(requests[index].s_url,
                              fit: BoxFit.cover,
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
                          fontSize: 15,
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


