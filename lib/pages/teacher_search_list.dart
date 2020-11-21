import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {

    final faculties=Provider.of<List<Teacher>>(context);

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
              },
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.deepPurple[100],
              ),
              title: Text(faculties[index].name),
              subtitle: Text(faculties[index].initials),
            ),
          ),
        );
      },
    );
  }
}
