import 'package:dev_hack/helper/Employee.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard(
      {required this.width, required this.height, required this.appointment, required this.listid, required this.delete});

  final double width;
  final double height;
  final Employee appointment;
  final int listid;
  final Function delete;


  @override
  State<AppointmentCard> createState() => _AppointmentCardState(listid, delete);
}

class _AppointmentCardState extends State<AppointmentCard> {

  final int listid;
  final Function delete;

  _AppointmentCardState(this.listid, this.delete);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 0.2 * widget.height,
        width: widget.width * 0.8,
        decoration: BoxDecoration(
            color: Color(0xFF3F826D).withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(widget.appointment.full_name, style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Stress Score", style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
                SizedBox(height: 10),
                Text(widget.appointment.wellness_score.toString(), style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
                SizedBox(height: 0.02 * widget.height)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed:  () {}, icon: Icon(Icons.info_outline_rounded)),
                IconButton(onPressed: () {
                  setState(() {delete(listid);});

                }, icon: Image.asset('assets/delete.png')),
              ],
            )
          ],
        ),
      ),
    );
  }
}