import 'package:flutter/material.dart';

import 'first_page.dart';

class Splash extends StatefulWidget {
  const Splash ({Key? key, required this.title}) : super (key: key);
  final String title;

  @override
  State<Splash> createState() => _Splash();
}

class _Splash extends State<Splash> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  void navigateFirstPage () async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FirstPage ()
        )
    );
  }

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _controller.forward();
    super.initState();

    navigateFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

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
                  'assets/cerc1.png',
                )
              ],
            ),
            Container(
                alignment: Alignment.center,
                width: 275,
                height: 185,
                child:ScaleTransition(
                  scale: _animation,
                  alignment: Alignment.center,
                  child: Image.asset('assets/logo.png'),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: _width,
                  child: Image.asset(
                    'assets/cerc2.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}