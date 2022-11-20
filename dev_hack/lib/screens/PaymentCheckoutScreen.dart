import 'package:flutter/material.dart';

import 'DownloadScreen.dart';
import 'LoadingScreen.dart';

class PaymentCheckoutScreen extends StatefulWidget {
  const PaymentCheckoutScreen({Key? key}) : super(key: key);
  static final routeName = '/payment';

  @override
  State<PaymentCheckoutScreen> createState() => _PaymentCheckoutScreenState();
}

class _PaymentCheckoutScreenState extends State<PaymentCheckoutScreen> {
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
            onPressed: () =>  Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Image.asset('assets/Component3.png'),
                alignment: Alignment.topLeft,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text("Payment checkout",
                    style: TextStyle(fontSize: 38)),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "70 €",
                    style: TextStyle(
                        fontSize: 70,
                        color: Colors.amber[700],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),

              Container(
                width: width,
                alignment: Alignment.bottomRight,
                child: Stack(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Image.asset('assets/Component4.png'),
                  ]),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                child: Text(
                                    "Continue to payment",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    )),
                                onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        LoadingScreen.routeName
                                    );
                                  }
                            ),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        )

    );
  }
}