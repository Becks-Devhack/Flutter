import 'package:dev_hack/screens/login_page.dart';
import 'package:flutter/material.dart';

import '../services/login_service.dart';
import '../services/registration_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController hospitalController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
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
            Text(
              'Sign up',
              selectionColor: Color.fromRGBO(28, 35, 33, 1),
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(37, 20, 37, 0),
              child: TextFormField(
                controller: hospitalController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.business_center_sharp),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'Company',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'First name',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
              child: TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'Last name',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_outlined),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'E-mail',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'Password',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color.fromRGBO(48, 131, 220, 0.2),)
                  ),
                  hintText: 'Confirm password',
                  fillColor: Color.fromRGBO(48, 131, 220, 0.2),
                ),
              ),
            ),

            ElevatedButton(
                child: Text(
                    "Sign up".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.red)
                        )
                    )
                ),
                onPressed: () =>
                  setState(() async {
                   var user = RegistrationUser(hospitalController.text, firstNameController.text, lastNameController.text,
                   emailController.text, passwordController.text, UserType.AppManager);
                   var registerResponse;
                   await user.registerUser().then((value) => registerResponse = value);
                   var userLog = LoginUser(emailController.text, passwordController.text);

                  if(registerResponse == RegistrationResponse.RegistrationSuccessful){
                    Navigator.pushNamed(context, LoginPage.routeName);
                  }
                  else{
                    showDialog(context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text(
                              "The registration went wrong, please try again!",
                              style: TextStyle(fontSize: 24.0),
                            ),
                          );
                        });
                  }


                }),

            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/Component4.png',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
