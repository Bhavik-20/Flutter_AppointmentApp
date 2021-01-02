import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appointment_app/model/Request.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/auth.dart';
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
//-------------------------------------------------------------------------------------------------------------------------------------//
  Future updateFacultyData(String name,String emp_code, String initials,String room,String email,String password, String downloadUrl) async
  {
    return await facultyCollection.document(uid).setData({
      'teacher_id':uid,
      'name': name,
      'employee_code': emp_code,
      'initials':initials,
      'room':room,
      'email':email,
      'password':password,
      'url':downloadUrl,
      'role':'faculty',
    });
  }

  Future updateStudentData(String name,String rollno,String branch,String year,String email,String password, String downloadUrl) async
  {
    return await studentCollection.document(uid).setData({
      'student_id':uid,
      'name': name,
      'roll no':rollno,
      'branch':branch,
      'year':year,
      'email':email,
      'password':password,
      'url':downloadUrl,
      'role':'student',
    });
  }
//-------------------------------------------------------------------------------------------------------------------------------------//
  Future updateRequests(String name,String rollno,String branch,String year,String email,String purpose,String time, String date, String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String teacher_id,String t_url, String s_url) async
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

  Future acceptRequests(String docid,String student_id,String name,String rollno,String branch,String year,String email,String purpose,String time, String date,String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String req_id,String teacher_id,String t_url, String s_url) async
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


  Future declineRequests(String docid, String student_id,String name,String rollno,String branch,String year,String email,String purpose,String time, String date,String teacherMail,String teacherName,String emp_code, String teacher_ini,String teacher_room,String req_id,String teacher_id,String t_url, String s_url) async
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
      'time': time,
      'date': date,
      'status':'Rejected',
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

  Future deleteRequests(String req_id) async
  {
    DocumentReference docref=requestCollection.document(req_id);
    return await docref.delete();
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
  //get faculty stream
  Stream<List<Teacher>> get faculties {
    return facultyCollection.snapshots()
        .map(_teacherListFromSnapshot);
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
        password: doc.data['password'] ?? '',
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
      password: snapshot.data['password'] ?? '',
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
//get faculty stream
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
        password: doc.data['password'] ?? '',
        url: doc.data['url'] ?? '',
      );
    }).toList();
  }
//-------------------------------------------------------------------------------------------//

  //get faculty doc stream
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
      password: snapshot.data['password'] ?? '',
      url: snapshot.data['url'] ?? '',
    );
  }
//-------------------------------------------------------------------------------------------//

}