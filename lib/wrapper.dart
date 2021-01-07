import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/pages/student__dashboard.dart';
import 'package:flutter_appointment_app/pages/teacher_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appointment_app/model/User.dart';


class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user==null) {
      return role();
    }

    else
    {
      String xyz="";
      var document =  Firestore.instance.collection('faculty').document(user.user_id);

      document.get().then((DocumentSnapshot document) {
        xyz=document.data['role'];

      });

      if(xyz=="faculty")
      {
        return teacher_dashboard();
      }
      else
      {
        return student_dashboard();
      }
    }
  }

}