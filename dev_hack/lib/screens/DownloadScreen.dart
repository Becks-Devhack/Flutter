import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../helper/HttpClass.dart';
import 'PaymentCheckoutScreen.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);
  static final routeName = '/download';

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

bool link_generated = false;
String link = 'dgfbdgfhnghngfhnfgmnfjhmhjmhgmhjmh';

// Future<void> downloadApk () async {
//   var dio = Dio();
//   try {
//     var response = await dio.download('http://192.168.22.141:3000', "/sdcard/download/app-debug.apk");
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }

Future getRequestAsync() async {
  HttpService service = HttpService();

  // StressLevel? res = await service.getRequest<StressLevel>();
  // stress_level = res!.stress_level;
  //
  // VacantionNeeded? res2 = await service.getRequest<VacantionNeeded>();
  // vacantion_needed = res2!.take_vacantion;
}

class _DownloadScreenState extends State<DownloadScreen> {
  final linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        onPressed: () => Navigator.pushNamed(context, PaymentCheckoutScreen.routeName),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 48,
                        )
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Application generated\nsuccessfully!",
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(28, 35, 33, 1),
                      ),
                      textAlign:TextAlign.center
                  )
                ],
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                    'assets/Asset 5@4x.png',
                    width: width/2),
              ]),

      !link_generated?
                  GestureDetector(
                    child: Text(
                      "Click here to generate link",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontStyle: FontStyle.italic,
                          color: Colors.amber[900]),
                    ),
                    onTap: () async {
                      await getRequestAsync();
                      setState(() {
                        linkController.text = link;
                        link_generated = true;
                      });
                    },
                  ):

                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF758ECD).withOpacity(0.2),
                      prefixIcon: const Icon(Icons.link),
                      hintText: 'Download Link',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: linkController,
                  ),
              Container(
                width: width,
                alignment: Alignment.bottomRight,
                child: Stack(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Image.asset('assets/Component4.png'),
                  ]),
                ]),
              ),
            ],
          ),
        )
    );

  }
}