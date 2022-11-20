import 'package:dev_hack/screens/upload_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'appFeatures_screen.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({Key? key}) : super(key: key);
  static const routeName = '/carousel';

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late List<Image> imgList = [
    Image.asset('assets/test.png'),
    Image.asset('assets/employee.png'),
  ];

  @override
  void didChangeDependencies() {
    precacheImage(imgList[0].image, context);
    precacheImage(imgList[1].image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                      )
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.all(18),
                child: Text(
                  'What do you want to do?',
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(28, 35, 33, 1),
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: height/2,
                  enlargeCenterPage: true,
                  viewportFraction: 2.0,
                ),
                items: [0,1].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                              width: MediaQuery.of(context).size.width/1.2,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              child:
                                Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child:
                                      Text(
                                          titleList[i],
                                      style: TextStyle(
                                        fontSize:25,
                                      ),),
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(50.0),
                                        child: imgList[i],
                                      ),
                                      onTap: () {
                                        if (i == 1) {
                                          Navigator.pushNamed(context, UploadEmployee.routeName);
                                        } else if (i == 0) {
                                          Navigator.pushNamed(context, AppFeaturesScreen.routeName);
                                        }
                                      }
                                    ),
                                  ],
                                )
                          );
                    },
                  );
                }).toList(),
              ),
            ),
            // Padding(padding: EdgeInsets.fromLTRB(0, 118, 0, 0)),
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
}

List titleList = [
  "Generate app",
  "Manage users",
];