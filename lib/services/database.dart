import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Student.dart';
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
        initials:doc.data['initials'] ?? '',
        email: doc.data['email'] ?? '',
        room: doc.data['room'] ?? '',
        password: doc.data['password'] ?? '',
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
      initials: snapshot.data['initials'],
      room: snapshot.data['room'],
      email: snapshot.data['email'],
      password: snapshot.data['password'] ?? '',
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
    );
  }
//-------------------------------------------------------------------------------------------//

}