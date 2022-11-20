import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hack/helper/Employee.dart';
import 'package:dev_hack/services/registration_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadEmployee extends StatefulWidget {
  const UploadEmployee({Key? key}) : super(key: key);
  static const routeName = '/upload_employee';

  @override
  State<UploadEmployee> createState() => _UploadEmployeeState();
}

bool are_employees = false;
CollectionReference _collectionRef = FirebaseFirestore.instance
    .collection('company')
    .doc('hEjaeUMSiFvCpEm0ZeSf')
    .collection('employee');





Future<int> countDocuments() async {
  QuerySnapshot querySnapshot = await _collectionRef.get();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  return allData.length;
}

class _UploadEmployeeState extends State<UploadEmployee> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add excel with employees to generate accounts',
                style: TextStyle(
                  fontSize: 34,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(28, 35, 33, 1),
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: countDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return are_employees
                      ? FutureBuilder(
                          future: countDocuments(),
                          builder: (context, newSnapshot) {
                            if (!newSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return Text(newSnapshot.data.toString());
                            }
                          })
                      : snapshot.data == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await importFile();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                      size: 100,
                                    ))
                              ],
                            )
                          : Text('ana are mere si pere');
                }
                // return FutureBuilder<int>(
                //   future: countDocuments(db),
                //   builder: (context, snapshot) {
                //     return !are_employees ?
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         IconButton(
                //             onPressed: () async {
                //               await importFile();
                //             },
                //             icon: Icon(
                //               Icons.add,
                //               color: Colors.blue,
                //               size: 100,
                //             )
                //         )
                //       ],
                //     ) :
                //     Text('ana are mere si pere');
                //     // } else {
                //     //   return const Center(
                //     //     child: CircularProgressIndicator(),
                //     //   );
                //     // }
                //   },
                // );
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
            employee, 'hEjaeUMSiFvCpEm0ZeSf', UserType.Doctor);
        await registration.registerUser().then((value) => print(value));
      }
    }

    setState(() {
      are_employees = true;
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

}
