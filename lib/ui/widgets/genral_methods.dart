import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Genral {
  static waiting(context) {
    Get.dialog(
      Container(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          
        ),
      )
    );
  }
}
