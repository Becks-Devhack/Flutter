import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

//import 'PageManager.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Stack(
            children: [
              Container(
                child: Column(
                    children: [Container(
                      child: Image.asset('assets/sus.png'),
                    ),
                    ]
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * 0.35,),
                      Container(child: Image.asset('assets/dreapta.png'),),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Image.asset('assets/jos.png'),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.2),
                          Container(
                              height: 0.2 * height,
                              child: Image.asset('assets/logoclinica.png')),
                          SizedBox(height: height * 0.05),
                          Container(
                            child: Text("Let's get you in",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: height * 0.05),
                          Container(
                            width: 0.8 * width,
                            child: Column(
                              children: [
                                TextFormField(
                                  // validator: (value) => EmailValidator.validate(value!)
                                  //     ? null
                                  //     : 'Invalid email address',
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: const Icon(Icons.email),
                                    filled: true,
                                    fillColor: Color(0xFF3F826D).withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF3F826D).withOpacity(0.2),
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  controller: passwordController,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, PageManager.routName);

                              if (_formKey.currentState!.validate()) {
                                var userSignin = {
                                  'email': '',
                                  'password': '',
                                };
                                userSignin['email'] = emailController.text;
                                userSignin['password'] = passwordController.text;

                                DatabaseReference database =
                                FirebaseDatabase.instance.ref('Users');
                                String keyUser = '';
                                database.once().then((data) {
                                  Map<String, dynamic> mapData =
                                  data.snapshot.value as Map<String, dynamic>;
                                  try {
                                    mapData.forEach((key, value) {
                                      print(value['email']);
                                      if ((value['email'] == userSignin['email']) &&
                                          (value['password'] ==
                                              userSignin['password'])) {
                                        keyUser = key;
                                        throw '';
                                      } else {
                                        keyUser = key;
                                        throw '';
                                      }
                                    });
                                  } catch (e) {
                                  } finally {
                                    if (keyUser == '') {
                                      SnackBar(
                                        content: new Text('Wrong email or password'),
                                        duration: new Duration(seconds: 5),
                                      );
                                    } else {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   PageManager.routName,
                                      //   arguments: keyUser,
                                      // );
                                    }
                                  }
                                });
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB23A48)),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Color(0xFFB23A48))))),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}