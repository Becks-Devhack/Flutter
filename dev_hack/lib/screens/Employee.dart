import 'package:dev_hack/helper/Employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'EmployeeCard.dart';


class AppointmentsPage extends StatefulWidget {

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {

  List<Empl>

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<AppointmentCard> appointmentsCards = [];

    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                height: 0.08 * height,
                child: Stack(
                    children: [
                      Image.asset('assets/sfera.png'),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Icon(Icons.menu, color: Colors.white),
                            )
                          ]
                      )
                    ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 0.1 * height,
                child: Text("New appointments", style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 0.69 * height,
                child: Center(
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) { return new AppointmentCard(width: width, height: height, appointment: appointments[index], delete: _deleteItem, listid: index); },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15,),
                      itemCount: appointments.length,
                    )
                ),
              )
            ],
          ),
        )
    );
  }

  int _deleteItem(int item) {
    setState(() {
      print(appointments.length);
      appointments.removeAt(item);
      print(appointments.length);
    });
    return 0;
  }
}