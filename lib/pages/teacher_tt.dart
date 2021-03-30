import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/TimeTable.dart';
import 'package:flutter_appointment_app/services/Api.dart';
import 'package:flutter_appointment_app/services/SharedPrefHelper.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TimeTable obj_tt;
  final AuthService _auth=AuthService();

  Future<int> sendFile(File file,String uid) async {
    print("ENTER FUNCTION");
    final CollectionReference timetableCollection =Firestore.instance.collection('timetable');
    try
    {
      print("TRY 1");
      var url =Uri.parse('http://10.0.2.2:8000');
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('file',file.path));
      var response2 = await request.send();
      var response = await http.Response.fromStream(response2);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201)
      {
        print("IF");
        print("FETCH ALBUM FOUND");
        print(response.body);
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print("jsonMap: "+jsonMap.toString());
        pdfModel = Api.fromJson(jsonMap);
        Api api_pdf=await new Api.fromJson(jsonMap);
        List<String> db_mon= api_pdf.mon.cast();
        List<String> db_tue= api_pdf.tue.cast();
        List<String> db_wed= api_pdf.wed.cast();
        List<String> db_thurs= api_pdf.thurs.cast();
        List<String> db_fri= api_pdf.fri.cast();
        print("DB:");
        print(api_pdf.mon.cast());
        try
        {
          print("TRY 2");
          await DatabaseService(uid: uid).updateTimeTable(
              db_mon,db_mon,db_tue,db_tue,db_wed,db_wed,db_thurs,db_thurs,db_fri,db_fri);
          print("Success");
          return 1;
          // return pdfModel;
        }
        catch(e)
        {
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: 'An Error occurred, Please try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          print("CATCH 2");
          print("ERROR:"+e.toString());
          return 0;
        }
      }
      else
      {
        print("ELSE");
      }
    }
    catch (e)
    {
      print("CATCH 1");
      print("ERROR:"+e.toString());
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
                //backgroundColor: Colors.deepPurple[100],
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
                  title: Text('Upload Time Table'),
                  centerTitle: true,
                ),
                body:DefaultTabController(
                  length: 5,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.deepPurple[100],
                        padding: EdgeInsets.symmetric(vertical:20,horizontal: 10),
                        width: size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  width: 40,
                                  height: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(5),
                                      color: kPrimaryColor,
                                      onPressed: () async {
                                        file = (await FilePicker.getFile(
                                            type: FileType.custom, allowedExtensions: ['pdf']));
                                        setState(() {
                                          loading=true;
                                          if(file != null)
                                            upload = "File uploaded";
                                        });
                                        if(file!=null)
                                        {
                                          print("FUNCTION CALLED");
                                          await sendFile(file,user.user_id);
                                          setState(() {
                                            loading=false;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(upload,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            // SizedBox(height: 5),
                            // Text("Previous Uploaded File : None",
                            //     style: TextStyle( fontSize: 10)
                            // ),
                            SizedBox(height: 10),
                            Text("Note: Please Upload Your TimeTable as a PDF File.",
                                style: TextStyle( fontSize: 15)
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.deepPurple[100],
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: TabBar(
                          tabs: [
                              Tab(child: Text("Mon", style: TextStyle(fontSize: 16),),),
                              Tab(child: Text("Tue", style: TextStyle(fontSize: 16),),),
                              Tab(child: Text("Wed", style: TextStyle(fontSize: 16),),),
                              Tab(child: Text("Thur", style: TextStyle(fontSize: 16),),),
                              Tab(child: Text("Fri", style: TextStyle(fontSize: 16),),),
                        ],
                        labelColor: kPrimaryColor,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: kPrimaryColor, width: 3)),
                        ),
                      ),
                      StreamBuilder<TimeTable>(
                        stream: DatabaseService(uid: user.user_id).tt_slots,
                        builder: (context,snapshot) {
                          print(snapshot);
                          if(snapshot.hasData)
                          {
                            print("STREAM TT HAS DATA");
                            return Expanded(
                              child: TabBarView(
                                children: [
                                  printSlots(snapshot.data.static_mon.cast(), size,"Monday"),
                                  printSlots(snapshot.data.static_tue.cast(), size,"Tuesday"),
                                  printSlots(snapshot.data.static_wed.cast(), size,"Wednesday"),
                                  printSlots(snapshot.data.static_thurs.cast(), size,"Thursday"),
                                  printSlots(snapshot.data.static_fri.cast(), size,"Friday"),
                                ],
                              ),
                            );
                          }
                          else
                          {
                            return Container(
                              child: Text("No Free Slots Uploaded"),
                            );
                          }
                        },
                      )
                  ],
                  ),
                ),
              );
          }
  }


Widget printSlots(List<String> day,Size size,String dayName)
{
  if(day.isEmpty)
    return Center(
      child: Column(
        children: [
          Image(
            image: AssetImage('images/timetable.jpg'),
            height: size.height * 0.5,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Please Upload Your TimeTable',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  else {
    //day.sort((a,b)=> a.compareTo(b));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Free slots on ' + dayName + ': ',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: [
                for ( int i = 0; i < day.length; i++ )
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      child: Text(
                        day[i],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 2)
                      ),
                    ),
                  )
              ],
            ),

          ],
        ),
      ),
    );
  }
}