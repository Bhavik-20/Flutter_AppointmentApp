import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {

    final faculties=Provider.of<List<Teacher>>(context)??[];

    return ListView.builder(
            itemCount: faculties.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(top:8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                  child: ListTile(
                    onTap: (){
                      print(faculties[index].email);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> student_bookAppointment(teacher:faculties[index])));
                    },
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.deepPurple[100],
                      child: ClipOval(
                        child: new SizedBox(
                          height: 180,
                          width:180,
                          child:(faculties[index].url == '' || faculties[index].url == null ) ? Image.asset('images/role_teacher.jpg',
                            fit: BoxFit.fill,) : Image.network(faculties[index].url,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    title: Text(faculties[index].employee_code+"_"+faculties[index].name),
                    subtitle: Text(faculties[index].initials),
                  ),
                ),
              );
            },
      );

  }
}
