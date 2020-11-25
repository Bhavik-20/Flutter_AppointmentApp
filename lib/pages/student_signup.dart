import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_appointment_app/ui_helpers/Loading.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_button.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_input_field.dart';
import 'package:flutter_appointment_app/ui_helpers/rounded_password_field.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:flutter_appointment_app/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class student_signup extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {

  final _formKey=GlobalKey<FormState>();
  final AuthService _auth=AuthService();

  String _branchVal;
  List _branch= ['Computer','Information Technology','Mechanical','Electronics','EXTC'];
  List _year=['FY','SY','TY','LY'];
  int selectedIndex = 0;

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
      year = _year[selectedIndex];
      print(year);
    });
  }

  String validate(String name, String rollno, String branch, String year, String email, String password)
  {
    RegExp ofname=new RegExp(r'^[A-Za-z ]*$');
    RegExp ofini=new RegExp(r'^[a-zA-Z_]*$');
    RegExp ofroll=new RegExp(r'^[0-9\-]*$');
    RegExp ofemail=new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (name.isEmpty || !ofname.hasMatch(name))
      return 'Invalid Name';
    if (rollno.isEmpty || !ofroll.hasMatch(rollno))
      return 'Invalid roll number';
    if (branch.isEmpty)
      return 'Select Branch';
    if (year.isEmpty)
      return 'Select Year';
    if (email.isEmpty || !ofemail.hasMatch(email))
      return 'Invalid Email format';
    if (password.isEmpty || password.length<6)
      return 'Password length should be 6 char';
    return 'valid';
  }
  bool _showPassword = false;

  //text field state
  String name="";
  String rollno="";
  String branch="";
  String year="";
  String email = "";
  String password = "";
  bool loading=false;

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
    return loading? Loading(): Form(
      key: _formKey,
      child: Scaffold(
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
                  onChanged: (value) {
                    setState(() => name=value);
                  },
                ),
                TextFieldContainer(
                  child: TextField(
                    onChanged: (value) {
                        setState(() => rollno=value);
                      },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(Icons.perm_identity,
                        color: kPrimaryColor,
                      ),
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
                              setState(() {
                                _branchVal = value;
                                branch=value;
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
                    onChanged: (value) {
                          setState(() => email=value);
                      },
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
                TextFieldContainer(
                  child: TextField(
                    obscureText: !this._showPassword,
                    onChanged: (value) {
                      setState(() => password=value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          this._showPassword ? Icons.visibility_off : Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() => this._showPassword = !this._showPassword);
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                RoundedButton(
                  text: "Sign Up",
                  press: ()  async {
                    String result=validate(name,rollno,branch,year,email,password);
                    if(result=='valid')
                    {
                      setState(() => loading=true);
                      dynamic result_auth = await _auth.registerStudent(name, rollno, branch, year, email, password,'');
                      if(result_auth == null)
                      {
                        setState(() {
                          loading=false;
                          Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            msg: 'An error occurred, please supply valid input',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        });
                      }
                      else
                      {
                        Fluttertoast.showToast(
                          backgroundColor: Colors.green,
                          msg: 'Successful',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.of(context).pushNamed('/st_dash');
                      }
                    }
                    else {
                      Fluttertoast.showToast(
                        backgroundColor: Colors.red,
                        msg: result,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                      );
                    }
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
      ),
    );
  }
}
