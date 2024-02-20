
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kezel/auth/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  final ctrl = Get.put(AuthController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscurepasswordText = true;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   ctrl.username.text='';
  //   ctrl.email.text='';
  //   ctrl.password.text='';
  //   ctrl.confirm_passwordController.text='';

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://c4.wallpaperflare.com/wallpaper/798/279/820/girl-creative-fire-cook-wallpaper-preview.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 90,
                  left: 20,
                ),
                color: Color.fromARGB(197, 39, 36, 41).withOpacity(.70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Welcome to',
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' \nDineDelight',
                            style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 25,
                              color: const Color.fromARGB(255, 247, 222, 0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Register Now !',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              height: MediaQuery.of(context).size.height / 2 + 50,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 1),
                            TextFormField(
                                controller: ctrl.username,
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
                                    Icons.person_outline,
                                    color: Color(0xFF666666),
                                  ),
                                  fillColor: Color.fromARGB(255, 232, 234, 239),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF666666),
                                  ),
                                  hintText: "Name",
                                ),
                                validator: (value) => value!.isEmpty
                                    ? 'Enter Your Name'
                                    : (nameRegExp.hasMatch(value)
                                        ? null
                                        : 'Enter a Valid Name')),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: ctrl.email,
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
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: ctrl.password,
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
                                  Icons.lock_outline,
                                  color: Color(0xFF666666),
                                ),
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
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: ctrl.confirm_passwordController,
                              obscureText: obscurepasswordText,
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
                                  Icons.lock_outline,
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
                                hintText: " Confirm Password",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "* Required";
                                } else if (value.length < 6) {
                                  return "Password should be atleast 6 characters";
                                } else if (value.length > 15) {
                                  return "Password should not be greater than 15 characters";
                                } else if (value.trim() !=
                                    ctrl.password.text.trim()) {
                                  print('Passwords do not match');
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            SizedBox(
                              height: 55,
                              width: 330,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ctrl.SignUp();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 9,
                                    shape: const StadiumBorder(),
                                    // backgroundColor:  Color.fromARGB(
                                    //     255, 151, 203, 240),
                                    backgroundColor: ctrl.loading.value
                                        ? Colors.red
                                        : Color.fromARGB(255, 151, 203, 240),
                                  ),
                                  child: ctrl.loading.value
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 200,
                              margin: EdgeInsets.only(top: 20),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "You already have an account ? ",
                                  style: TextStyle(
                                    color: Color(0XFF9BB3C0),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pop();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
