import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_app/model/Teacher.dart';
import 'package:flutter_appointment_app/pages/student_bookAppointment.dart';
import 'package:flutter_appointment_app/ui_helpers/constants.dart';
import 'package:flutter_appointment_app/ui_helpers/text_field_container.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {

  TextEditingController editingController = TextEditingController();
  var items = List<Teacher>();

  @override
  Widget build(BuildContext context) {

    final faculties=Provider.of<List<Teacher>>(context)??[];
    List<Teacher> search_name=[];
    faculties.asMap().forEach((key, value) {
    //  String format_name=value.employee_code+"_"+value.name;
      search_name.add(value);
    });

    void filterSearchResults(String query) {
      List<Teacher> dummySearchList = List<Teacher>();
      dummySearchList.addAll(search_name);
      if(query.isNotEmpty) {
        List<Teacher> dummyListData = List<Teacher>();
        dummySearchList.forEach((item) {
          if(item.name.toLowerCase().contains(query.toLowerCase()) || item.initials.toLowerCase().contains(query.toLowerCase()) || item.employee_code.contains(query)) {
            dummyListData.add(item);
          }
        });
        setState(() {
          items.clear();
          items.addAll(dummyListData);
        });
        if(items.length == 0){
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: 'No Result Found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          );
        }
      } else {
        setState(() {
          items.clear();
          items.addAll(search_name);
        });

      }
    }

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Search",
                  icon: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                    itemCount: items.length == 0 ? faculties.length : items.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.only(top:8.0),
                        child: Card(
                          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                          child: ListTile(
                            onTap: (){
                              print(search_name);
                              print(faculties[index].email);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> student_bookAppointment(teacher:faculties[index])));
                            },
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.deepPurple[100],
                              child: ClipOval(
                                child: new SizedBox(
                                  height: 180,
                                  width:180,
                                  child:(items.length==0)?(faculties[index].url == '' || faculties[index].url == null ) ? Image.asset('images/role_teacher.jpg',
                                      fit: BoxFit.fill) : Image.network(faculties[index].url,
                                      fit: BoxFit.fill) :( (items[index].url == '' || items[index].url == null ) ? Image.asset('images/role_teacher.jpg',
                                    fit: BoxFit.fill) : Image.network(items[index].url,
                                    fit: BoxFit.fill)),
                                ),
                              ),
                            ),
                            title:items.length==0?Text(faculties[index].employee_code+"_"+faculties[index].name):Text(items[index].employee_code+"_"+items[index].name),
                            subtitle:items.length==0? Text(faculties[index].initials):Text(items[index].initials),
                          ),
                        ),
                      );
                    },
              ),
          ),
        ],
      ),
    );

  }
}
