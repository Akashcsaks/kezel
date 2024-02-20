
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kezel/auth/auth.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage>
    with SingleTickerProviderStateMixin {
  /// TODO Variable
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController userEmailController = new TextEditingController();
  final ctrl = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrl.rest_email.text='';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              /// Status Bar
              Container(padding: EdgeInsets.only(top: 5.0)),

              /// Title
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 35.0),
                child: Text('Reset Password', style: TextStyle(fontSize: 35.0)),
              ),

              /// Subtitle
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 85.0),
                child: Text(
                  '   Please enter your email to receive a'
                  '\nlink to create a new password via Email',
                ),
              ),

              /// Form
              Container(
                padding: EdgeInsets.only(top: 180.0),
                child: Column(
                  children: [
                    /// email
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
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
                          // decoration: textFieldInputDecoration('Email'),
                          controller: ctrl.rest_email,
                          validator: (val) {
                            return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(val!)
                                ? null
                                : "Valid email required";
                          },
                        ),
                      ),
                    ),

                    /// Button
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => MaterialButton(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(55)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ctrl.resetPassword();
                                  }
                                },
                                child: ctrl.loading.value
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Send',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
