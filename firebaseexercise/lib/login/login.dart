import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kezel/auth/auth.dart';
import 'package:kezel/home.dart';
import 'package:kezel/login/forgotpassword.dart';
import 'package:kezel/login/register.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscurepasswordText = true;
  final ctrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://t3.ftcdn.net/jpg/01/91/29/14/360_F_191291499_M7dnv8VA0RkRvnX3GxVX9ZKAv8wJsNZ5.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 90,
                  left: 20,
                ),
                color: Color.fromARGB(197, 37, 41, 46).withOpacity(.70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Welcome to',
                            style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: const Color.fromARGB(255, 247, 222, 0),
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                            text: ' \nKezel',
                            style: TextStyle(
                                letterSpacing: 0,
                                fontSize: 25,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          )
                        ])),
                    Text(
                      'Signup to Continue',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0,
                      ),
                    )
                  ],
                ),
              ),
            )),
        Positioned(
          top: 250,
          child: Container(
              height: MediaQuery.of(context).size.height / 2 + 100,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ]),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 1),
                            TextFormField(
                              controller: ctrl.login_email,
                              showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF666666),
                                ),
                                fillColor: Color.fromARGB(255, 232, 234, 239),
                                hintStyle: TextStyle(
                                  color: Color(0xFF666666),
                                ),
                                hintText: "Email",
                              ),
                              validator: (val) {
                                return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(val!)
                                    ? null
                                    : "Valid email required";
                              },
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              obscureText: obscurepasswordText,
                              controller: ctrl.login_password,
                              showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.fingerprint,
                                  color: Color(0xFF666666),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscurepasswordText =
                                            !obscurepasswordText;
                                      });
                                    },
                                    icon: obscurepasswordText
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Color(0xFF666666),
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Color(0xFF666666),
                                          )),
                                fillColor: Color.fromARGB(255, 232, 234, 239),
                                hintStyle: TextStyle(
                                  color: Color(0xFF666666),
                                ),
                                hintText: "Password",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "* Required";
                                } else if (value.length < 6) {
                                  return "Password should be atleast 6 characters";
                                } else if (value.length > 15) {
                                  return "Password should not be greater than 15 characters";
                                } else
                                  return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Add the TextButton widget inside the children list
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordPage(),
                                    ));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0XFFA7BCC7)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                              height: 55,
                              width: 330,
                              child: Obx(
                                () => ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        //change
                                        ctrl.signin();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 9,
                                      shape: const StadiumBorder(),
                                      backgroundColor: ctrl.loading.value
                                          ? Colors.red
                                          : Color.fromARGB(255, 151, 203, 240),
                                    ),
                                    child: ctrl.loading.value
                                        ? CircularProgressIndicator(
                                            color: Colors.white)
                                        : Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                            ),
                                          )),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    height: 1.0,
                                    width: 60.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Or',
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    height: 1.0,
                                    width: 60.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Bounceable(
                              child: Container(
                                width: 50, // Adjust as needed
                                height: 50, // Adjust as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.white, // Optional background color
                                ),
                                child: Image.asset(
                                  'images/google.png',
                                  fit: BoxFit.cover,
                                ), // Replace with your image
                              ),
                              onTap: () async {
                                print('Google');
                                try {
                                  final userCredential =
                                      await signInWithGoogle();
                                  Get.snackbar("Login successfully",
                                      "Welcome to Kezel ",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white);
                                  Get.off(() => Home());
                                  final User user = userCredential.user!;
                                  final email = user.email;
                                  final name = user.displayName;

                                  // Print the email and name
                                  print('Email: $email');
                                  print('Name: $name');
                                  // Handle successful sign-in (e.g., navigate to user profile)
                                } on Exception catch (e) {
                                  Get.snackbar("Error", '$e',
                                      colorText: Color.fromARGB(255, 59, 1, 1));
                                }
                              },
                            ),
                            SizedBox(height: 11),
                            Container(
                              width: 200,
                              margin: EdgeInsets.only(top: 20),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "You don't have an account ? ",
                                  style: TextStyle(color: Color(0XFF9BB3C0)),
                                  children: [
                                    TextSpan(
                                      text: "Register",
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const Register(),
                                          ));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        )
      ]),
    );
  }
}


