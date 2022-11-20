import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_page.dart';

class FirstPage extends StatefulWidget{
  const FirstPage ({Key? key}) : super (key: key);

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage  extends State<FirstPage>{
  int activeIndex = 0;
  bool autoplay = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    void navigateLogin (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage ()
          )
      );
    }

    Widget generateCard(String title, String info) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: GestureDetector(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, _height / 10, 0, 0),
                child:Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(232, 233, 235, 1),
                  ),
                ),
              ),
              if (info.isNotEmpty == true)
                Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(232, 233, 235, 1),
                  ),
                ),
            ],
          ),
          onTap: navigateLogin,
        ),
      );
    }

    Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 3,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/cerc4.png',
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: 275,
              height: 150,
              child: Image.asset('assets/logo.png'),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: _width,
                        child: Image.asset(
                          'assets/cerc3.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.4 * _height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            switch(index) {
                              case 0:
                                return generateCard('Welcome!', 'Build an application for all your hospital needs in no more than couple of minutes.');
                              case 1:
                                return generateCard('Customizable applications', 'Choose the templates based on your own necessities.');
                              case 2:
                                return generateCard('Start improving your workflow!', '');
                            }
                            return SizedBox.shrink();
                          },
                          options: CarouselOptions(
                              autoPlay: autoplay,
                              viewportFraction: 1,
                              autoPlayInterval: Duration(seconds: 5),
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) => {
                                if (index == 2) {
                                  setState(() => {
                                    activeIndex = index,
                                    autoplay = false
                                  })
                                } else
                                  setState(() => activeIndex = index)
                              }
                          ),
                        ),
                        // Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                        SizedBox(height: 0.05 * _height,),
                        buildIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
