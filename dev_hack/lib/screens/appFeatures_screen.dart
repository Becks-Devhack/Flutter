import 'package:flutter/material.dart';


class AppFeaturesScreen extends StatefulWidget {
  const AppFeaturesScreen({Key? key}) : super(key: key);
  static const routeName = '/features';

  @override
  State<AppFeaturesScreen> createState() => _AppFeaturesScreenState();
}

class _AppFeaturesScreenState extends State<AppFeaturesScreen> {
  bool _valueAddPrescription = false;
  bool pressedButton = false;


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
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset('assets/Component3.png'),
              alignment: Alignment.topLeft,
            ),
            Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.centerRight,
                child: Text.rich(
                  TextSpan(
                      text: 'What features do you need?',
                      style: TextStyle(
                        fontSize: 35.0,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                              child: Icon(
                                Icons.info_outlined,
                                color: Colors.black,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.lightBlue[700],
                                        content: Text(
                                          "Log In and Health status of user are mandatory for your application. "
                                              "Now, depending on the desired features, additional costs may apply.",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        actions: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () =>
                                                    Navigator.pop(context, true)),
                                          )
                                        ]);
                                  },
                                );
                              }),
                        ),
                      ]),
                )),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                    activeColor: Colors.amber[900],
                    title: const Text('Log in', style: TextStyle(fontSize: 25)),
                    subtitle: const Text(
                        "User will be able to log in into an existing account\n"
                            "FREE",
                        style: TextStyle(fontSize: 15)),
                    value: true,
                    onChanged: null,
                  ),
                  SwitchListTile(
                      activeColor: Colors.amber[900],
                      title: const Text('Health status of user',
                          style: TextStyle(fontSize: 25)),
                      subtitle: const Text(
                          "User will be able to see personal information about his medical condition\n"
                              "FREE",
                          style: TextStyle(fontSize: 15)),
                      value: true,
                      onChanged: null),
                  SwitchListTile(
                      activeColor: Colors.amber,
                      title: const Text('Daily recomandations',
                          style: TextStyle(fontSize: 25)),
                      subtitle: const Text(
                          "User will get daily recommendations in healthcare and entertainment\n"
                              + "20€",
                          style: TextStyle(fontSize: 15)),
                      value: _valueAddPrescription,
                      onChanged: (bool value) {
                        setState(() {
                          _valueAddPrescription = value;

                        });
                      }),
                ],
              ),
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
                                  "Click to generate\n application",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  )),
                              onTap: () {
                                // Navigator.push<Widget>(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AddHospitalLogoScreen(),
                                //   ),
                                // );}
                              }
                          ),
                          SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),



          ]),
    );
  }
}