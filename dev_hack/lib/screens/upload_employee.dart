import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hack/helper/Employee.dart';
import 'package:dev_hack/services/registration_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'EmployeeCard.dart';

class UploadEmployee extends StatefulWidget {
  const UploadEmployee({Key? key}) : super(key: key);
  static const routeName = '/upload_employee';

  @override
  State<UploadEmployee> createState() => _UploadEmployeeState();
}

bool are_employees = false;
bool are_employees2 = false;
CollectionReference _collectionRef = FirebaseFirestore.instance
    .collection('company')
    .doc('W1yutMLrJ2wiWuHWR0Hy')
    .collection('employee');

class _UploadEmployeeState extends State<UploadEmployee> {
  var db = FirebaseFirestore.instance;

  List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/Component3.png',
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 48,
                    )),
              )
            ],
          ),
          Container(
            height: 0.1 * height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Employee List", style: TextStyle(
                  fontSize: 34,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(28, 35, 33, 1),
                ),),
              ],
            ),
          ),
          !are_employees2 ? Container(
            height: 0.2 * height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add excel with employees to generate accounts',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(28, 35, 33, 1),
                  ),
                ),
              ],
            ),
          ) : Container(),
          FutureBuilder(
              future: countDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return are_employees2
                      ? StreamBuilder(
                          stream: _collectionRef.snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return Container(
                                height: 0.6 * height,
                                child: new ListView(
                                    children: getExpenseItems(snapshot)),
                              );
                            }
                          })
                      : snapshot.data?.length == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 0.1 * height,
                                  child: IconButton(
                                      onPressed: () async {
                                        await importFile();
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                      )),
                                )
                              ],
                            )
                          : Text("");
                }
              }),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Image.asset('assets/Component4.png'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> importFromExcel(PlatformFile file) async {
    var bytes = File(file.path!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      int i = 0;
      for (var row in excel.tables[table]!.rows) {
        if (i == 0) {
          i++;
          continue;
        }

        var row_map = row.asMap();
        String email = '';
        String full_name = '';
        row_map.forEach((key, value) {
          switch (key) {
            case 0:
              email = value!.value;
              break;
            case 1:
              full_name = value!.value;
              break;
          }
        });

        Employee employee = Employee(email, full_name);
        var registration = RegistrationUser.FromRegistrationUser(
            employee, 'W1yutMLrJ2wiWuHWR0Hy', UserType.Doctor);
        await registration.registerUser().then((value) => print(value));
      }
    }

    setState(() {
      are_employees2 = true;
    });
  }

  Future importFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    final file = result.files.first;
    await importFromExcel(file);
  }

  Future<List<Object?>> countDocuments() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      are_employees = true;
    });
    return allData;
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc) => Card(
          child: new ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(doc["wellness"])],
                  ),
                ),
                title: new Text(doc["fullName"]),
                subtitle: TextButton(onPressed: () {}, child: Text("A day off request was submitted", style: TextStyle(color: Color(0xfff5cb5c)),),),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.desktop_access_disabled_outlined)),
              ),
        ))
        .toList();
  }

  int _deleteItem(int item) {
    setState(() {
      print(employeeList.length);
      employeeList.removeAt(item);
      print(employeeList.length);
    });
    return 0;
  }
}
