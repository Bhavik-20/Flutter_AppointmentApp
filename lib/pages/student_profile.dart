import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Student.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class student_profile extends StatefulWidget {
  @override
  _student_profileState createState() => _student_profileState();
}

class _student_profileState  extends State<student_profile> {

  final _formKey = GlobalKey<FormState>();
  String downloadUrl="";
  String name = "";
  String roll = "";
  String branch = "";
  String year = "";
  String email = "";
  String password = "";
  bool loading = false;
  int b = 0;
  int y = 0;
  List _branch = [
    'Computer',
    'Information Technology',
    'Mechanical',
    'Electronics',
    'EXTC'
  ];
  List _year = ['FY', 'SY', 'TY', 'LY','MTech'];

  String validate(String name, String rollno, String branch, String year) {
    RegExp ofname = new RegExp(r'^[A-Za-z ]*$');
    RegExp ofini = new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroll = new RegExp(r'^[0-9\-]*$');
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (rollno.isEmpty || !ofroll.hasMatch(rollno))
      return 'Invalid roll number';
    if (branch.isEmpty)
      return 'Select Branch';
    if (year.isEmpty)
      return 'Select Year';
    return 'valid';
  }

  var _image;

  @override
  Widget build(BuildContext context) {

      final user = Provider.of<User>(context);

      Size size = MediaQuery
          .of(context)
          .size;

      return StreamBuilder<Student>(
          stream: DatabaseService(uid: user.user_id).studentData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Student data = snapshot.data;
              if (loading) {
                return Loading();
              } else {
                return Form(
                key: _formKey,
                child: Scaffold(
                  backgroundColor: Colors.deepPurple[50],
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.of(context).pushNamed('/st_dash');
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    backgroundColor: Colors.deepPurple[600],
                    title: Text('Student Profile',
                      style:TextStyle(
                        fontSize: size.width*0.05,
                      ) ,),
                    centerTitle: true,
                    actions: [
                      Icon(Icons.person_pin_rounded,
                        size: 30.0,)
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect (
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                    height: 200,
                                    color: Colors.deepPurple[400],
                                    child: Image.asset('images/bg2.jpg', fit:BoxFit.fill)
                                  ),
                              ),
                            ),
                            SizedBox(height: 40.0,),
                            Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))
                                  ),
                                  width: size.width * 0.8,
                                  child: Column(
                                      children: [
                                        Container(
                                          height: 50.0,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: TextFormField(
                                              initialValue: data.name,
                                              enabled: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.05,
                                                fontFamily: 'playfair',
                                              ),
                                              onChanged: (value) {
                                                setState(() => name = value);
                                              },
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Full Name',
                                              )
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.deepPurple[100],
                                          thickness: 1,
                                        ),
                                        Container(
                                          height: 50.0,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: TextFormField(
                                              initialValue: data.roll,
                                              enabled: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.05,
                                                fontFamily: 'playfair',
                                              ),
                                              onChanged: (value) {
                                                setState(() => roll = value);
                                              },
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Roll Number',
                                              )
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.deepPurple[100],
                                          thickness: 1,
                                        ),
                                        Container(
                                          height: 50.0,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: TextFormField(
                                              initialValue: data.branch,
                                              enabled: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.05,
                                                fontFamily: 'playfair',
                                              ),
                                              onChanged: (value) {
                                                setState(() => branch = value);
                                              },
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Branch',
                                              )
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.deepPurple[100],
                                          thickness: 1,
                                        ),
                                        Container(
                                          height: 50.0,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: TextFormField(
                                              initialValue: data.year,
                                              enabled: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.05,
                                                fontFamily: 'playfair',
                                              ),
                                              onChanged: (value) {
                                                setState(() => year = value);
                                              },
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Year',
                                              )
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.deepPurple[100],
                                          thickness: 1,
                                        ),
                                        Container(
                                          height: 50.0,
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: TextFormField(
                                            initialValue: data.email,
                                            enabled: false,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.05,
                                              fontFamily: 'playfair',
                                            ),
                                            decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'E-Mail',
                                            ),
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(height: 30.0,),
                            RoundedButton(
                              text: 'Save Changes',
                              press: () async {

                                  name = name.isEmpty ? data.name : name;
                                  roll = roll.isEmpty ? data.roll : roll;
                                  branch = branch.isEmpty ? data.branch : branch;
                                  year = year.isEmpty ? data.year : year;
                                  email = data.email;
                                  downloadUrl = downloadUrl.isEmpty? data.url : downloadUrl;

                                  print(name);
                                  print(roll);
                                  print(branch);
                                  print(year);
                                  print(email);
                                  print(password);

                                  if (_branch.contains(branch)) {
                                    b = 1;
                                  }
                                  else {
                                    Fluttertoast.showToast(
                                      backgroundColor: Colors.red,
                                      msg: 'Please enter a valid branch.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,);
                                  }

                                  if (_year.contains(year)) {
                                    y = 1;
                                  }
                                  else {
                                    Fluttertoast.showToast(
                                      backgroundColor: Colors.red,
                                      msg: 'Please enter a valid year.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,);
                                  }

                                  String result = validate(
                                      name, roll, branch, year);
                                  if (result == 'valid' && b == 1 && y == 1) {
                                    setState(() => loading = true);
                                    await DatabaseService(uid: user.user_id)
                                        .updateStudentData(
                                        name,
                                        roll,
                                        branch,
                                        year,
                                        email);
                                    print('hey');
                                    Fluttertoast.showToast(
                                      backgroundColor: Colors.green,
                                      msg: 'Successfully Updated Data',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                    Navigator.pop(context);
                                    // Navigator.of(context).pushNamed('/st_dash');
                                  }
                                  else if (result != 'valid') {
                                    Fluttertoast.showToast(
                                      backgroundColor: Colors.red,
                                      msg: result,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                    );
                                  }
                              }
                            ),
                            SizedBox(height: 30.0,),
                          ],
                        ),
                        Positioned(
                          top: size.height*0.125,
                          child:  Center(
                              child: Align(
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.grey,
                                  child: ClipOval(
                                    child: new SizedBox(
                                      width: 180.0,
                                      height: 180.0,
                                      child:(_image == null && data.url == '') ? Image.asset('images/profile_student.png',
                                        fit: BoxFit.cover,) : ((_image != null)?Image.file(_image,
                                        fit: BoxFit.cover,):(data.url != '')?Image.network(data.url,
                                        fit: BoxFit.cover,):Image.asset('images/profile_student.png',
                                        fit: BoxFit.cover,)),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                        Positioned(
                          top: size.height*0.25,
                          left: size.width*0.55,
                          child:Align(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30))
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.camera_alt,
                                    size: 30.0,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    //getImage();
                                    return showDialog(
                                      context: context,
                                      builder: (context)=> AlertDialog(
                                        contentPadding: EdgeInsets.all(5),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              child: Text('Upload/Edit Photo',
                                              style: TextStyle(
                                                fontSize: size.width * 0.05,
                                              ),
                                              ),
                                              onPressed:()async {
                                                // ignore: deprecated_member_use
                                                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                                Navigator.pop(context);
                                                setState(() {
                                                  loading=true;
                                                  _image = image;
                                                  print('Image Path $_image');
                                                });

                                                //photo upload
                                                if(_image != null) {
                                                  String fileName = basename(_image.path);
                                                  StorageReference firebaseStorageRef = FirebaseStorage
                                                      .instance.ref()
                                                      .child(fileName);
                                                  StorageUploadTask uploadTask = firebaseStorageRef
                                                      .putFile(_image);
                                                  StorageTaskSnapshot taskSnapshot = await uploadTask
                                                      .onComplete;
                                                  setState(() {
                                                    print("Profile Picture uploaded");
                                                  });

                                                  if (taskSnapshot.error == null) {
                                                    downloadUrl =
                                                    await taskSnapshot.ref.getDownloadURL();
                                                    print(downloadUrl);
                                                  }
                                                }
                                                //photo upload ends
                                                if(downloadUrl !="") {
                                                  await DatabaseService(uid: user.user_id)
                                                      .updatePhoto("student", downloadUrl);
                                                  setState(() {
                                                    loading=false;
                                                  });
                                                }
                                                },
                                            ),
                                            FlatButton(
                                              child: Text('Delete Photo',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                ),
                                              ),
                                              onPressed: () async {
                                                try {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await DatabaseService(uid: user.user_id).removePhoto("student");
                                                  await DatabaseService().removePhotoFromStorage(data.url);
                                                  Fluttertoast.showToast(
                                                    backgroundColor: Colors.green,
                                                    msg: 'Your Profile Picture has been Deleted Successfully.',
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                  );
                                                  setState(() {
                                                    _image = null;
                                                    loading = false;
                                                  });
                                                }
                                                catch (e) {
                                                  Fluttertoast.showToast(
                                                    backgroundColor: Colors.red,
                                                    msg: 'An error occcured.',
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    );
                                  },
                                ),
                            ),
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
              }
            }
            else {
              return Loading();
            }
          }
      );
    }
  }
