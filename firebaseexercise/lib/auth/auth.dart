import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kezel/auth/model.dart';
import 'package:kezel/home.dart';
import 'package:kezel/login/login.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  //reg
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();
  TextEditingController password = TextEditingController();
  //login
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();
  //reset
  TextEditingController rest_email = TextEditingController();

  //create function//create acc with email&password
  SignUp() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await addUser();
      Get.snackbar(
        "Registraction successfully",
        'Login to Continue',
        backgroundColor: Colors.green,
      );
      Get.off(() => login());

      loading.value = false;
    } catch (e) {
      Get.snackbar("Error", '$e', colorText: Color.fromARGB(255, 59, 1, 1));
      print(
          ":::::::::::::::::::::::::::::::::::::::::::::::Error occurred: $e");

      loading.value = false;
    }
  }

  //add user to database
  addUser() async {
    UserModel user = UserModel(
      username: username.text,
      email: auth.currentUser?.email,
    );
    await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection("Profile")
        .add(user.toMap());
  }

  //signout
  signout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    Get.off(() => login());
  }

  //signin
  signin() async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(
          email: login_email.text, password: login_password.text);
      Get.snackbar("Login successfully", "Welcome to Kezel ",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.off(() => Home()); //home
      loading.value = false;
    } catch (e) {
      Get.snackbar("Error", '$e', colorText: Color.fromARGB(255, 59, 1, 1));
      print(
          ":::::::::::::::::::::::::::::::::::::::::::::::Error occurred: $e");
      loading.value = false;
    }
  }

  //resetpassword
  resetPassword() async {
    try {
      loading.value = true;
      await auth.sendPasswordResetEmail(email: rest_email.text);
      Get.snackbar("Email", 'send successfully', backgroundColor: Colors.green);
      // Get.to(()=>login());
      loading.value = false;
    } catch (e) {
      Get.snackbar("Error", '$e', colorText: Color.fromARGB(255, 59, 1, 1));
      loading.value = false;
    }
  }
}

Future<UserCredential> signInWithGoogle() async {
  final googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  } else {
    throw Exception('Google Sign-In canceled');
  }
}
