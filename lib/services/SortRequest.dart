import 'package:flutter_appointment_app/model/Request.dart';
import 'package:intl/intl.dart';

class SortRequest
{

      int check(String date, String date2, String time, String time2, String type)
      {
        String a = date
            .split(":")
            .last
            .trim();
        String b = date2
            .split(":")
            .last
            .trim();
        time = time
            .split("-")
            .first;
        time2 = time2
            .split("-")
            .first;
        DateTime dt1 = DateTime.parse(a + " " + time);
        DateTime dt2 = DateTime.parse(b + " " + time2);
        // print(dt1);
        // print(dt2);
        // print(dt1.compareTo(dt2));
        if(type == 'a')
          return dt1.compareTo(dt2);
        else
          return dt2.compareTo(dt1);
      }

}