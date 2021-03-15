import 'dart:convert';

import 'package:flutter_appointment_app/services/Api.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/model/User.dart';
import 'package:flutter_appointment_app/pages/role.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:flutter_appointment_app/services/database.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';


class teacher_tt extends StatefulWidget {
  @override
  _teacher_ttState createState() => _teacher_ttState();
}

class _teacher_ttState extends State<teacher_tt> {

  File file;
  String upload = "Please upload the PDF";
  bool loading=false;
  var obj;
  var pdfModel;
  final AuthService _auth=AuthService();

  @override
  Future<Api> sendFile(File file) async {
    print("ENTER FUNCTION");

    try
    {
      var client = http.Client();
      print("TRYYYYYYY");
      var url =Uri.parse('http://10.0.2.2:8000');
      var request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath(
              'file',
              file.path
          )
      );
      var response2 = await request.send();
      var response = await http.Response.fromStream(response2);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201)
      {
        print("IFFFF");
        print("FETCH ALBUM FOUND");
        print(response.body);
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print("jsonMap: "+jsonMap.toString());
        pdfModel = Api.fromJson(jsonMap);

      }
      else
      {
        print("ELSEEE");
      }
    }
    catch (e)
    {
      print("CATCHHHHH");
      print("ERROR:"+e.toString());
      return pdfModel;
    }
    return pdfModel;
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _formKey=GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return user==null ? role() : StreamBuilder<Teacher>(
        stream: DatabaseService(uid: user.user_id).facultyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Teacher data = snapshot.data;
            return loading? Loading() : Form(
              key: _formKey,
              child: MaterialApp(
                home: Scaffold(
                  backgroundColor: Colors.deepPurple[100],
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/tea_dash');
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    backgroundColor: Colors.deepPurple[600],
                    title: Text('Upload Time Table'),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            color: kPrimaryColor,
                            onPressed: () async {
                              file = (await FilePicker.getFile(
                                  type: FileType.custom, allowedExtensions: ['pdf']));
                              setState(() {
                                if(file != null)
                                  upload = "File uploaded";
                              });
                              if(file!=null)
                              {
                                print("FUNCTION CALLED");
                                obj= sendFile(file);
                              }
                            },
                            child: Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                          SizedBox(height: 150),
                          Text(upload,
                            style: TextStyle(fontSize: 20),
                          ),
                      SizedBox(height: 150),
                      if(upload!="Please upload the PDF...")

                          Center(
                            child: FutureBuilder<Api>(
                              future: obj,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.tue[1].toString());
                                }
                                else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                print("SNAP NO DATA");
                                return CircularProgressIndicator();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              );
          }
          else {
            return Loading();
          }
        });
  }
}