import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(role());
}

class role extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple[50],
          body:Column(
            children: [
              SizedBox(height: size.height * 0.2),
              Container(
                //margin: EdgeInsets.only(left: 0.0,top: 200.0),
                child: Center(
                  child: Text('Meet Up',
                    style: GoogleFonts.pacifico(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: size.height * 0.065,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05,width: size.width*0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/st_login');
                          },
                          child: Image.asset('images/role_student.jpg' ,
                          width: size.width*0.375,)
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text('I am a Student',
                        style: GoogleFonts.pacifico(
                          color: Colors.deepPurple,
                          fontSize: size.width * 0.05,
                        ),),
                    ],
                  ),
                  SizedBox(width: size.width * 0.001),
                  Column(
                    children: [
                      FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/tea_login');
                          },
                          child: Image.asset('images/role_teacher.jpg',
                            width: size.width*0.375,)
                      ),
                      SizedBox(height: size.height * 0.01),
                        Text('I am a Teacher',
                        style: GoogleFonts.pacifico(
                        color: Colors.deepPurple,
                          fontSize: size.width * 0.05,
                        ),),
                    ],
                  ),
                ],
              ) ,
              SizedBox(height: 80.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, color: Colors.deepPurple, size: 12,),
                  Icon(Icons.circle, color: Colors.deepPurple, size: 15,),
                  SizedBox(width: 10,),
                  Text("Meetings Made Easy",
                  style: TextStyle(
                    fontSize: 18,
                  )),
                  SizedBox(width: 10,),
                  Icon(Icons.circle, color: Colors.deepPurple, size: 15,),
                  Icon(Icons.circle, color: Colors.deepPurple, size: 12,),
                ],
              ),
            ],
          )
      ),
    );
  }
}