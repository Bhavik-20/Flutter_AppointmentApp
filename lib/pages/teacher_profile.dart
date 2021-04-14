import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class teacher_profile extends StatefulWidget {
  @override
  _teacher_profileState createState() => _teacher_profileState();
}

class _teacher_profileState extends State<teacher_profile> {


  final _formKey=GlobalKey<FormState>();
  String downloadUrl="";
  String name="";
  String emp_code="";
  String initials="";
  String room="";
  String email="";
  String tt_status="";
  bool loading=false;

  // List<String> tt_mon;
  // List<String> tt_tue;
  // List<String> tt_wed;
  // List<String> tt_thurs;
  // List<String> tt_fri;

  String validate(String name, String emp_code, String initials, String room)
  {
    RegExp ofname=new RegExp(r'^[A-Za-z ]*$');
    RegExp ofcode=new RegExp(r'^[0-9]{1,6}$');
    RegExp ofini=new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroom=new RegExp(r'^[A-Za-z0-9\-]*$');
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (emp_code.isEmpty || !ofcode.hasMatch(emp_code))
      return 'Invalid Employee Code';
    if (initials.isEmpty || !ofini.hasMatch(initials))
      return 'Invalid Initials';
    if (room.isEmpty || !ofroom.hasMatch(room))
      return 'Invalid Room Number';
    return 'valid';
  }
  var _image;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    Size size = MediaQuery.of(context).size;
    return StreamBuilder<Teacher>(
      stream: DatabaseService(uid: user.user_id).facultyData,
      builder: (context,snapshot){
        if(snapshot.hasData)
          {
            Teacher data=snapshot.data;

             return loading? Loading():Form(
              key: _formKey,
              child: Scaffold(
                backgroundColor: Colors.deepPurple[100],
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                      // Navigator.of(context).pushNamed('/tea_dash');
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  backgroundColor: Colors.deepPurple[600],
                  title: Text('Teacher Profile'),
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
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                width: size.width*0.8,
                                child: Column(
                                    children: [
                                      Container(
                                        height:50.0,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child:TextFormField(
                                          initialValue: data.name ,
                                          enabled: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.045,
                                              fontFamily: 'playfair',
                                            ),
                                          onChanged: (value){
                                            setState(() => name=value);
                                          },
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                            hintText: 'Full Name',
                                          )
                                        )
                                      ),
                                      Divider(
                                        color: Colors.deepPurple[100],
                                        thickness: 1,
                                      ),
                                      Container(
                                          height:50.0,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child:TextFormField(
                                              initialValue: data.employee_code ,
                                              enabled: true,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 0.045,
                                                fontFamily: 'playfair',
                                              ),
                                              onChanged: (value){
                                                setState(() => emp_code=value);
                                              },
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Employee Code',
                                              )
                                          )
                                      ),
                                      Divider(
                                        color: Colors.deepPurple[100],
                                        thickness: 1,
                                      ),
                                      Container(
                                        height:50.0,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child:TextFormField(
                                          initialValue:data.initials,
                                          enabled: true,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.045,
                                              fontFamily: 'playfair',
                                            ),
                                          onChanged: (value){
                                            setState(() => initials=value);
                                          },
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Initials',
                                          )
                                        )
                                      ),
                                      Divider(
                                        color: Colors.deepPurple[100],
                                        thickness: 1,
                                      ),
                                      Container(
                                        height:50.0,
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: TextFormField(
                                          initialValue: data.room,
                                          enabled: true,
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.045,
                                          fontFamily: 'playfair',
                                        ),
                                          onChanged: (value){
                                            setState(() => room=value);
                                          },
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Room',
                                          ),
                                        )
                                      ),
                                      Divider(
                                        color: Colors.deepPurple[100],
                                        thickness: 1,
                                      ),
                                      Container(
                                        height:50.0,
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: TextFormField(
                                          initialValue: data.email,
                                          enabled: false,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.width * 0.045,
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
                              name= name.isEmpty ? data.name : name;
                              emp_code=emp_code.isEmpty ? data.employee_code : emp_code;
                              initials= initials.isEmpty ? data.initials : initials;
                              room= room.isEmpty ? data.room : room;
                              email=data.email;
                              tt_status=data.tt_status;
                              downloadUrl = downloadUrl.isEmpty? data.url : downloadUrl;

                              print(name);
                              print(initials);
                              print(room);
                              print(email);
                              print(tt_status);

                              String result = validate(name, emp_code, initials, room);
                              if (result == 'valid') {
                                setState(() => loading = true);
                                await DatabaseService(uid: user.user_id)
                                    .updateFacultyData(name, emp_code, initials, room, email, tt_status);
                                Fluttertoast.showToast(
                                  backgroundColor: Colors.green,
                                  msg: 'Successfully Updated Data',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                );
                                Navigator.pop(context);
                                // Navigator.of(context).pushNamed('/tea_dash');
                              }
                              else {
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
                                    child:(_image == null && data.url == '') ? Image.asset('images/profile_faculty.png',
                                      fit: BoxFit.cover,) : ((_image != null)?Image.file(_image,
                                      fit: BoxFit.cover,):(data.url != '')?Image.network(data.url,
                                      fit: BoxFit.cover,):Image.asset('images/profile_faculty.png',
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
                                  return showDialog(
                                    context: context,
                                    builder: (context)=> AlertDialog(
                                      contentPadding: EdgeInsets.all(5),
                                      content: Container(
                                        height: 100,//size.height*0.15,
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              child: Text('Upload/Edit Photo',
                                              style: TextStyle(
                                                fontSize: size.width * 0.05,
                                              ),),
                                              onPressed:() async {
                                                // ignore: deprecated_member_use
                                                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                                setState(() {
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
                                                await DatabaseService(uid: user.user_id)
                                                    .updatePhoto("faculty",downloadUrl);

                                                Fluttertoast.showToast(
                                                    backgroundColor: Colors.green,
                                                    msg: 'Your Profile Photo has been Updated.',
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                );
                                                },
                                            ),
                                            FlatButton(
                                              child: Text('Delete Photo',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await DatabaseService(uid: user.user_id).removePhoto("faculty");
                                                print("Profile photo deleted.");
                                                Fluttertoast.showToast(
                                                    backgroundColor: Colors.green,
                                                    msg: 'Your Profile Picture has been Deleted Successfully.',
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                );
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
        else
          {
            return Loading();
          }
      },
    );
  }

}
