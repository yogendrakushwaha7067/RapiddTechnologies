// home_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_app/screen/home_screen.dart';

import '../Model/course_model.dart';

class LoginController extends GetxController {
  bool isvisible=false;
  bool isloading=false;
  updatevisible(){
    isvisible=!isvisible;
    update();
  }

  registerUser(String email,String password) async {
    isloading=true;
    update();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {

        Get.offAll(()=>HomeScreen());
        Fluttertoast.showToast(
            msg: "User Registered Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
      isloading=false;
      update();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isloading=false;
        update();
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (e.code == 'email-already-in-use') {
        isloading=false;
        update();
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } catch (e) {
      isloading=false;
      update();
      print(e);
    }
  }


}
