import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/TimeTable.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
//-------------------------------------------------------------------------------------------------------------------------------------//
  //collection reference
  final CollectionReference facultyCollection =Firestore.instance.collection('faculty');
  final CollectionReference studentCollection =Firestore.instance.collection('student');
  final CollectionReference requestCollection =Firestore.instance.collection('request');
  final CollectionReference acceptCollection =Firestore.instance.collection('accepted');
  final CollectionReference declineCollection =Firestore.instance.collection('rejected');
  // final CollectionReference timetableCollection =Firestore.instance.collection('timetable');

//-------------------------------------------------------------------------------------------------------------------------------------//
  Future updateFacultyData(String name,String emp_code, String initials,String room,String email,String tt_status) async
  {
    return await facultyCollection.document(uid).setData({
      'teacher_id':uid,
      'name': name,
      'employee_code': emp_code,
      'initials':initials,
      'room':room,
      'email':email,
      'tt_status':tt_status,
      //'url':downloadUrl,
      'role':'faculty',
    });
  }

  Future updateTimeTable(List<String> static_mon,List<String> dynamic_mon,List<String> static_tue,List<String> dynamic_tue,
      List<String> static_wed,List<String> dynamic_wed,List<String> static_thurs,List<String> dynamic_thurs,
      List<String> static_fri,List<String> dynamic_fri) async
  {
    CollectionReference  timetableCollection=facultyCollection.document(uid).collection("timetable");
    return await timetableCollection.document(uid).setData(
        {
          'static_mon': static_mon,
          'dynamic_mon': dynamic_mon,
          'static_tue': static_tue,
          'dynamic_tue': dynamic_tue,
          'static_wed': static_wed,
          'dynamic_wed': dynamic_wed,
          'static_thurs': static_thurs,
          'dynamic_thurs': dynamic_thurs,
          'static_fri': static_fri,
          'dynamic_fri': dynamic_fri,
        }
    );
  }

  Future updateStudentData(String name,String rollno,String branch,String year,String email) async
  {
    return await studentCollection.document(uid).setData({
      'student_id':uid,
      'name': name,
      'roll no':rollno,
      'branch':branch,
      'year':year,
      'email':email,
      'role':'student',
    });
  }
//-------------------------------------------------------------------------------------------------------------------------------------//
  Future updateRequests(String name,String rollno,String branch,String year,String email,String purpose, String purpose_details,String time, String date, String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String teacher_id,String t_url, String s_url) async
  {
    DocumentReference docref=requestCollection.document();
    return await docref.setData({
      'student_id':uid,
      'student_name': name,
      'student_rollno':rollno,
      'student_branch':branch,
      'student_year':year,
      'student_mail':email,
      'purpose':purpose,
      'purpose_details':purpose_details,
      'time': time,
      'date': date,
      'status':'Pending',
      'teacher_id':teacher_id,
      'teacher_mail':teacherMail,
      'teacher_name': teacherName,
      'employee_code': emp_code,
      'teacher_ini': teacher_ini,
      'teacher_room': teacher_room,
      'request_id':docref.documentID,
      't_url':t_url,
      's_url':s_url,
    });
  }

  Future acceptRequests(String docid,String student_id,String name,String rollno,String branch,String year,String email,String purpose,String purpose_details,String time, String date,String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String req_id,String teacher_id,String t_url, String s_url) async
  {
    DocumentReference docref=acceptCollection.document(docid);
    return await docref.setData({
      'student_id':student_id,
      'student_name': name,
      'student_rollno':rollno,
      'student_branch':branch,
      'student_year':year,
      'student_mail':email,
      'purpose':purpose,
      'purpose_details':purpose_details,
      'time': time,
      'date': date,
      'status':'Accepted',
      'teacher_id':teacher_id,
      'teacher_mail':teacherMail,
      'teacher_name': teacherName,
      'employee_code': emp_code,
      'teacher_ini': teacher_ini,
      'teacher_room': teacher_room,
      'request_id':req_id,
      't_url':t_url,
      's_url':s_url,
    });
  }


  Future declineRequests(String docid, String student_id,String name,String rollno,String branch,String year,String email,String purpose,String purpose_details,String time, String date,String status,String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String req_id,String teacher_id,String t_url, String s_url) async
  {
    DocumentReference docref=declineCollection.document(docid);
    return await docref.setData({
      'student_id':student_id,
      'student_name': name,
      'student_rollno':rollno,
      'student_branch':branch,
      'student_year':year,
      'student_mail':email,
      'purpose':purpose,
      'purpose_details': purpose_details,
      'time': time,
      'date': date,
      'status': status,
      'teacher_mail':teacherMail,
      'teacher_name': teacherName,
      'employee_code': emp_code,
      'teacher_ini': teacher_ini,
      'teacher_room': teacher_room,
      'request_id':req_id,
      'teacher_id':teacher_id,
      't_url':t_url,
      's_url':s_url,
    });
  }

  Future removeSlot(String time,String remove_from) async
  {
    DocumentReference timetableDocument=facultyCollection.document(uid).collection("timetable").document(uid);
    print("REMOVE SLOT , TIME: "+time);
    print("REMOVE SLOT , FROM: "+remove_from);
    return await timetableDocument.updateData({
      remove_from : FieldValue.arrayRemove([time])
    });
  }

  Future addSlot(String time,String add_to) async
  {
    add_to = add_to.split(":").first.trim();
    String field="";
    if(add_to=="Monday")
    {
      field="dynamic_mon";
    }
    else if(add_to=="Tuesday")
    {
      field="dynamic_tue";
    }
    else if(add_to=="Wednesday")
    {
      field="dynamic_wed";
    }
    else if(add_to=="Thursday")
    {
      field="dynamic_thurs";
    }
    else if(add_to=="Friday")
    {
      field="dynamic_fri";
    }

    print("ADD SLOT , TIME: "+time);
    print("ADD SLOT , FROM: "+field);
    DocumentReference timetableDocument=facultyCollection.document(uid).collection("timetable").document(uid);
    print("REMOVE SLOT , TIME: "+time);
    print("REMOVE SLOT , FROM: "+add_to);
    return await timetableDocument.updateData({
      field : FieldValue.arrayUnion([time])
    });
  }

  Future deleteRequests(String req_id) async
  {
    DocumentReference docref=requestCollection.document(req_id);
    return await docref.delete();
  }

  Future removePhotoFromStorage(String url) async
  {
    StorageReference photoRef = await FirebaseStorage.instance
        .ref()
        .getStorage()
        .getReferenceFromUrl(url);
    await photoRef.delete();
  }

  Future removePhoto(String role_call) async {
// remove photo from profile and requests
  print("REMOVE PHOTO");
  String fieldname="";
  String fieldname2="";
  if(role_call=="faculty")
    {
      await facultyCollection.document(uid).updateData({
        "url" : ""
      });
      fieldname="teacher_id";
      fieldname2="t_url";
      print("REMOVE PHOTO 1");
    }
  else if(role_call=="student")
    {
      await studentCollection.document(uid).updateData({
        "url" : ""
      });
      fieldname="student_id";
      fieldname2="s_url";
      print("REMOVE PHOTO 2");
    }

  await requestCollection.where(fieldname,isEqualTo: uid).getDocuments()
      .then((querySnapshot){
    querySnapshot.documents.forEach((doc) {
      doc.reference.updateData({
        fieldname2 : ""
      });
    });
  });
  print("REMOVE PHOTO 3");

  await acceptCollection.where(fieldname,isEqualTo: uid).getDocuments()
      .then((querySnapshot){
    querySnapshot.documents.forEach((doc) {
      doc.reference.updateData({
        fieldname2 : ""
      });
    });
  });
  print("REMOVE PHOTO 4");

  await declineCollection.where(fieldname,isEqualTo: uid).getDocuments()
      .then((querySnapshot){
    querySnapshot.documents.forEach((doc) {
      doc.reference.updateData({
      fieldname2 : ""
      });
    });
  });
  print("REMOVE PHOTO 5");
  }

  Future updatePhoto(String role_call, String url) async{
    print("UPLOAD PHOTO");
    String fieldname="";
    String fieldname2="";
    if(role_call=="faculty")
    {
      await facultyCollection.document(uid).updateData({
        "url" : url
      });
      fieldname="teacher_id";
      fieldname2="t_url";
      print("UPLOAD PHOTO 1");
    }
    else if(role_call=="student")
    {
      await studentCollection.document(uid).updateData({
        "url" : url
      });
      fieldname="student_id";
      fieldname2="s_url";
      print("UPLOAD PHOTO 2");
    }
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: 'Your Profile Photo has been Updated.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );

    await requestCollection.where(fieldname,isEqualTo: uid).getDocuments()
        .then((querySnapshot){
      querySnapshot.documents.forEach((doc) {
        doc.reference.updateData({
          fieldname2 : url
        });
      });
    });
    print("UPLOAD PHOTO 3");

    await acceptCollection.where(fieldname,isEqualTo: uid).getDocuments()
        .then((querySnapshot){
      querySnapshot.documents.forEach((doc) {
        doc.reference.updateData({
          fieldname2 : url
        });
      });
    });
    print("UPLOAD PHOTO 4");

    await declineCollection.where(fieldname,isEqualTo: uid).getDocuments()
        .then((querySnapshot){
      querySnapshot.documents.forEach((doc) {
        doc.reference.updateData({
          fieldname2 : url
        });
      });
    });
    print("UPLOAD PHOTO 5");
  }
//-------------------------------------------------------------------------------------------------------------------------------------//

  Stream<List<Request>> get teacher_unanswered  {
    return requestCollection.where('teacher_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }

  Stream<List<Request>> get teacher_accepted  {
    return acceptCollection.where('teacher_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }
  Stream<List<Request>> get teacher_rejected  {
    return declineCollection.where('teacher_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }

  Stream<List<Request>> get student_unanswered {
    return requestCollection.where('student_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }

  Stream<List<Request>> get student_accepted  {
    return acceptCollection.where('student_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }

  Stream<List<Request>> get student_rejected  {
    return declineCollection.where('student_id',isEqualTo: uid).snapshots().map(_RequestModalSnapshot);
  }

  List<Request> _RequestModalSnapshot(QuerySnapshot snapshot)
  { print("Uid:");
    print(uid);
    return snapshot.documents.map((doc){
      return Request(
        date: doc.data['date'],
        purpose: doc.data['purpose'],
        purpose_details: doc.data['purpose_details'],
        status: doc.data['status'],
        student_branch: doc.data['student_branch'],
        student_mail: doc.data['student_mail'],
        student_name: doc.data['student_name'],
        student_rollno: doc.data['student_rollno'],
        student_year: doc.data['student_year'],
        teacher_id: doc.data['teacher_id'],
        teacher_mail: doc.data['teacher_mail'],
        teacher_name: doc.data['teacher_name'],
        employee_code:doc.data['employee_code'],
        teacher_ini: doc.data['teacher_ini'],
        teacher_room: doc.data['teacher_room'],
        time: doc.data['time'],
        request_id: doc.data['request_id'],
        student_id: doc.data['student_id'],
        t_url: doc.data['t_url'],
        s_url: doc.data['s_url'],
      );
    }).toList();
  }

//-------------------------------------------------------------------------------------------//
  // get TimeTable for logged in Faculty
  Stream<TimeTable> get tt_slots {
    CollectionReference  timetableCollection=facultyCollection.document(uid).collection("timetable");
    return timetableCollection.document(uid).snapshots().map(_slotsFromSnapshot);
  }

  TimeTable _slotsFromSnapshot(DocumentSnapshot snapshot)
  {
    return TimeTable(
        static_mon: snapshot.data['static_mon'] ,
        dynamic_mon: snapshot.data['dynamic_mon'],
        static_tue: snapshot.data['static_tue'] ,
        dynamic_tue: snapshot.data['dynamic_tue'],
        static_wed: snapshot.data['static_wed'] ,
        dynamic_wed: snapshot.data['dynamic_wed'],
        static_thurs: snapshot.data['static_thurs'] ,
        dynamic_thurs: snapshot.data['dynamic_thurs'],
        static_fri: snapshot.data['static_fri'] ,
        dynamic_fri: snapshot.data['dynamic_fri'],
      );
  }
//-------------------------------------------------------------------------------------------//
  //get faculty stream
  Stream<List<Teacher>> get faculties {
    return facultyCollection.snapshots().map(_teacherListFromSnapshot);
  }

  // faculty list from snapshot
  List<Teacher> _teacherListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Teacher(
        name: doc.data['name'] ?? '',
        employee_code: doc.data['employee_code'] ?? '',
        initials:doc.data['initials'] ?? '',
        email: doc.data['email'] ?? '',
        room: doc.data['room'] ?? '',
        tt_status: doc.data['tt_status'] ?? '',
        teacher_id: doc.data['teacher_id'] ?? '',
        url: doc.data['url'] ?? '',
      );
    }).toList();
  }

//-------------------------------------------------------------------------------------------//
  //get faculty doc stream
  Stream<Teacher> get facultyData{
    return facultyCollection.document(uid).snapshots().map(_facultyDataFromSnapshot);
  }

  // faculty data from snapshot
  Teacher _facultyDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return Teacher(
      name: snapshot.data['name'],
      employee_code: snapshot.data['employee_code'] ?? '',
      initials: snapshot.data['initials'],
      room: snapshot.data['room'],
      email: snapshot.data['email'],
      tt_status: snapshot.data['tt_status'] ?? '',
      teacher_id: snapshot.data['teacher_id'] ?? '',
      url: snapshot.data['url'] ?? '',
    );
  }
//-------------------------------------------------------------------------------------------//

  //get data from db for students
  Stream<QuerySnapshot> get student {
    return studentCollection.snapshots();
  }

  //get data from db for faculty
  Stream<QuerySnapshot> get faculty {
    return facultyCollection.snapshots();
  }

//-------------------------------------------------------------------------------------------//
  //get student stream
  Stream<List<Student>> get students {
    return studentCollection.snapshots()
        .map(_studentListFromSnapshot);
  }

  // faculty list from snapshot
  List<Student> _studentListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Student(
        name: doc.data['name'] ?? '',
        roll:doc.data['roll'] ?? '',
        branch: doc.data['branch'] ?? '',
        year: doc.data['year'] ?? '',
        email: doc.data['email'] ?? '',
        url: doc.data['url'] ?? '',
      );
    }).toList();
  }
//-------------------------------------------------------------------------------------------//

  //get student doc stream
  Stream<Student> get studentData{
    return studentCollection.document(uid).snapshots().map(_studentDataFromSnapshot);
  }

  // faculty data from snapshot
  Student _studentDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return Student(
      name: snapshot.data['name'],
      roll: snapshot.data['roll no'],
      branch: snapshot.data['branch'],
      year: snapshot.data['year'] ,
      email: snapshot.data['email'],
      url: snapshot.data['url'] ?? '',
    );
  }
//-------------------------------------------------------------------------------------------//

}