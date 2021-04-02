import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

      return user==null ? role() : StreamBuilder<Teacher>(
        stream : DatabaseService(uid: user.user_id).facultyData,
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return teacher_dashboard();
            }
          else
            {
              return student_dashboard();
            }
        },
      );

    // if (user==null)
    // {
    //   return role();
    // }
    //
    // else
    // {
    //   String xyz="";
    //   var document =  Firestore.instance.collection('faculty').document(user.user_id);
    //
    //   document.get().then((DocumentSnapshot document) {
    //     xyz=document.data['role'];
    //
    //
    //   });
    //
    //   if(xyz=="faculty")
    //   {
    //     return teacher_dashboard();
    //   }
    //   else
    //   {
    //     return student_dashboard();
    //   }
    //   return teacher_dashboard();
    // }
  }

}