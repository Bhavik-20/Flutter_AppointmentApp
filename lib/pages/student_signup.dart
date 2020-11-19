import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

// void main(){
//   runApp(student_signup());
// }
class student_signup extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  String _branchVal;
  List _branch= ['Computer','Information Technology','Mechanical','Electronics','EXTC'];
  List _year=['FY','SY','TY','LY'];
  int selectedIndex = 0;

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  Widget customRadio(String txt,int index){
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color: selectedIndex == index ? kPrimaryColor : Colors.grey, width: 3),
      child: Text(txt,style: TextStyle(color: selectedIndex == index ?kPrimaryColor : Colors.grey),),

    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
                  IconButton(
                    icon: Icon(Icons.arrow_back ),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/st_login');
                    },
                  ),
                  SizedBox(width: 50.0),
                  Text(
                    "Student Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'dosis',
                        fontSize: 40
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Image(
                image: AssetImage('images/student.jpg'),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Full Name",
                onChanged: (value) {},
              ),
              TextFieldContainer(
                child: TextField(
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity,
                      color: kPrimaryColor,
                    ),
                    // labelText: 'Roll Number',
                    // labelStyle: TextStyle(
                    //   color: kPrimaryColor,
                    // ),
                    hintText: 'Roll Number',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10,0,0,0),
                  width: size.width * 0.8,
                  child: Row(
                    children: [
                    Text( 'Branch:',
                   style: TextStyle(fontSize: 16),
                    ),

                     Container(
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.fromLTRB(20,5,10,5),
                      child: DropdownButton(
                          hint: Text('Branch'),
                          dropdownColor: kPrimaryLightColor,
                          elevation: 5,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          value: _branchVal,
                          style: TextStyle(color: Colors.black , fontSize: 16.0),
                          onChanged: (value){
                            setState((){
                              _branchVal = value;
                          });
                        },
                        items: _branch.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    ],),
                    ),
              Container(
                  child: Text('Select Year',
                  style: TextStyle(color: Colors.black , fontSize: 16.0), ),
                margin: EdgeInsets.fromLTRB(0,20,0,5),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  customRadio(_year[0], 0),
                  customRadio(_year[1], 1),
                  customRadio(_year[2], 2),
                  customRadio(_year[3], 3),
                ],
              ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              TextFieldContainer(
                child: TextField(
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Somaiya Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
              RoundedButton(
                text: "Sign Up",
                press: () {
                  Navigator.of(context).pushNamed('/st_login');
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.purple[100],
                        )
                    ),
                    SizedBox(width: 5.0,),
                    Text("Already Signed Up?",
                      style: TextStyle(
                          fontFamily: 'dosis',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.purple[100],
                        )
                    ),
                  ]
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryLightColor,
                  onPressed: (){
                    Navigator.of(context).pushNamed('/st_login');
                  },
                  child: Text(
                    'Sign In here',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
