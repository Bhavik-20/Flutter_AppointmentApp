import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(role());
}

class role extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple[50],
          body:Column(
            children: [
              SizedBox(height: 150.0),
              Container(
                //margin: EdgeInsets.only(left: 0.0,top: 200.0),
                child: Center(
                  child: Text('Meet Up',
                    style: GoogleFonts.pacifico(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60.0,width: 10.0),
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
                          width: 150,)
                      ),
                      SizedBox(height: 10.0),
                      Text('I am a Student',
                        style: GoogleFonts.pacifico(
                          color: Colors.deepPurple,
                          fontSize: 20,
                        ),),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/tea_login');
                          },
                          child: Image.asset('images/role_teacher.jpg',
                            width: 150,)
                      ),
                      SizedBox(height: 10.0),
                        Text('I am a Teacher',
                        style: GoogleFonts.pacifico(
                        color: Colors.deepPurple,
                        fontSize: 20,
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