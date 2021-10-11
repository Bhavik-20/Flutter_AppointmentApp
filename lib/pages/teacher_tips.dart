import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';


class teacher_tips extends StatefulWidget {

  @override
  teacher_tipsState createState() => new teacher_tipsState();
}

//------------------ Custom config ------------------
class teacher_tipsState extends State<teacher_tips> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "",
          description: "",
          backgroundImage: 'images/teacher_profile.jpg',
          backgroundOpacity: 0
      ),
    );
    slides.add(
      new Slide(
          title: "",
          description: "",
          backgroundImage: "images/Timetable_screen.jpg",
          backgroundOpacity: 0
      ),
    );
    slides.add(
      new Slide(
          title: "",
          description: "",
          backgroundImage: "images/teacher_req.jpg",
          backgroundOpacity: 0
      ),
    );
    slides.add(
      new Slide(
          title: "",
          description: "",
          backgroundImage: "images/teacher_req_details.png",
          backgroundOpacity: 0
      ),
    );
    slides.add(
      new Slide(
          title: "",
          description: "",
          backgroundImage: "images/teacher_history.png",
          backgroundOpacity: 0
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushNamed('/tea_dash');
  }

  Widget renderNextBtn() {
    return Text(
      'NEXT',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      'DONE',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      'SKIP',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33000000),
      highlightColorSkipBtn: Color(0xff000000),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),

      // Dot indicator
      colorDot: Colors.black,
      colorActiveDot: Colors.white,
      sizeDot: 8.0,

      // Show or hide status bar
      shouldHideStatusBar: true,

    );
  }
}

