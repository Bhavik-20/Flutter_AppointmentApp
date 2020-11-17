import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(role());
}

class role extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.deepPurple[600],
          body:Column(
            children: [
              SizedBox(height: 200.0),
              Container(
                //margin: EdgeInsets.only(left: 0.0,top: 200.0),
                child: Center(
                  child: Icon(Icons.account_circle,
                    color: Colors.white,
                    size: 150.0,),
                ),
              ),
              SizedBox(height: 60.0,width: 20.0),
              Container(
                width: 200.0,
                child: RaisedButton(
                  elevation: 20.0,
                  color: Colors.white,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Teacher Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'dosis',
                            fontWeight: FontWeight.bold,
                        ) ,
                      ),
                      SizedBox(width: 10.0),
                      Icon(Icons.person)
                    ],
                  ),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/tea_login');
                  },
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.white)
                  ),
                ),
              ) ,
              SizedBox(height: 20.0,width: 20.0),
              Container(
                width: 200.0,
                child: RaisedButton(
                  elevation: 20.0,
                  color: Colors.white,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Student Login',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'dosis',
                          fontWeight: FontWeight.bold,
                        ) ,
                      ),
                      SizedBox(width: 10.0),
                      Icon(Icons.psychology_outlined)
                    ],
                  ),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/st_login');
                  },
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.white)
                  ),
                ),
              ) ,
            ],
          )
      ),
    );
  }
}