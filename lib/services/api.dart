import 'package:chat_me/getx_providers/phone_auth/phone_auth.dart';
import 'package:chat_me/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class APIs {
  FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneAuthDataProvider phoneAuthDataProvider = PhoneAuthDataProvider();

  Future registerUser(String mobile, BuildContext context) async {
    print("hello From registerUser ");
    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("hello From verificationCompleted ");
          await _auth.signInWithCredential(credential).then((value) {
            print(value.user.uid);
            Get.off("/UserInfo");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("hello From verificationFailed ");
          print("erro from verificationFailed =========${e.toString()}");
          Get.snackbar(" verification Failed", "${e.message}",
          colorText: BLACK_COLOR
         // snackPosition: SnackPosition.BOTTOM,
          );
         
        },
        codeSent: (String verificationId, int resendToken) async {
          print("hello From codeSent ");
          
         
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("hello From codeAutoRetrievalTimeout ");
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }
}
