import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Our App'),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              'Welcome to our app',
                  style: TextStyle(
                color: Colors.yellowAccent,
                    fontSize: 20.0
            ),
            ),
          ),
        ),

      ),
    );
  }
}