import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {

  final String username = "meetup.somaiya@gmail.com";
  final String password = "B7P10M20";


  sendMailToTeacher(String to, String from, String stu_email, String stu_year, String stu_branch, String stu_roll, String purpose, String date, String time) async
  {
    final smtpServer = gmail(username, password);
    String text = """ 
                                REQUEST DETAILS \n
    Student name : ${from},\n
    Student email : ${stu_email}, \n
    Student year : ${stu_year},\n
    Student branch : ${stu_branch},\n
    Student roll number : ${stu_roll},\n
    Appointment purpose : ${purpose},\n
    Appointment date and time : ${date} , ${time}
    
                         Open MeetUp to see further details of this request.
    
    ~ MeetUp
    """;
    final message = Message()
      ..from = Address(username)
      ..recipients.add(to)
      ..subject = "MeetUp : You have a new appointment Request"
      ..text = text;

    try
    {
      final sendReport = await send(message, smtpServer);
      print('Mail sent: ' + sendReport.toString()); //print if the email is sent
    }
    on MailerException catch (e)
    {
      print('Mail not sent. \n'+ e.toString()); //print if the email is not sent
    }
  }

  sendMailToStudent(String to, String from, String tea_email, String tea_ini, String tea_room, String purpose, String date, String time, String status) async
  {
    final smtpServer = gmail(username, password);

    String subject = "MeetUp : Your Appointment Request with ${from} has been ${status.split(".").first}";

    String text = """ 
                                REQUEST DETAILS \n
    Faculty name : ${from},\n
    Faculty email : ${tea_email},\n
    Faculty initials : ${tea_ini},\n
    Faculty room : ${tea_room},\n
    Appointment purpose : ${purpose},\n
    Date and time : ${date.split(":").first}
                      ${date.split(":").last},
                      ${time},\n
    Appointment Status : ${status.split(".").first}
    
    Open MeetUp to see further details of this request.
    
    ~ MeetUp
    """;
    final message = Message()
      ..from = Address(username)
      ..recipients.add(to)
      ..subject = subject
      ..text = text;

    try
    {
      final sendReport = await send(message, smtpServer);
      print('Mail sent: ' + sendReport.toString()); //print if the email is sent
    }
    on MailerException catch (e)
    {
      print('Mail not sent. \n'+ e.toString()); //print if the email is not sent
    }
  }
}