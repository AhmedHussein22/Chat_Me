import 'package:get/get.dart';

class PhoneAuthDataProvider extends GetxController {
  String smsCode="";
  void setSmsCode(String sms) {
    smsCode = sms;
    update();
  }
}
