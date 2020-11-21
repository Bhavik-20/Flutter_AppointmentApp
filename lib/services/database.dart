import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});


  //collection reference
  final CollectionReference facultyCollection =Firestore.instance.collection('faculty');
  final CollectionReference studentCollection =Firestore.instance.collection('student');

  Future updateFacultyData(String name,String initials,String room,String email,String password) async
  {
    return await facultyCollection.document(uid).setData({
      'faculty_id':uid,
      'name': name,
      'initials':initials,
      'room':room,
      'email':email,
      'password':password,
      'role':'faculty',
    });
  }

  Future updateStudentData(String name,String rollno,String branch,String year,String email,String password) async
  {
    return await studentCollection.document(uid).setData({
      'student_id':uid,
      'name': name,
      'roll no':rollno,
      'branch':branch,
      'year':year,
      'email':email,
      'password':password,
      'role':'student',
    });
  }

  //get data from db for faculty
  Stream<QuerySnapshot> get faculty {
    return facultyCollection.snapshots();
  }

  // faculty list from snapshot
  List<Teacher> _teacherListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Teacher(
        name: doc.data['name'] ?? '',
        initials:doc.data['initials'] ?? '',
        email: doc.data['email'] ?? '',
        room: doc.data['room'] ?? '',
      );
    }).toList();
  }

  //get faculty stream
  Stream<List<Teacher>> get faculties {
    return facultyCollection.snapshots()
        .map(_teacherListFromSnapshot);
  }

  //get data from db for students
  Stream<QuerySnapshot> get student {
    return studentCollection.snapshots();
  }

}