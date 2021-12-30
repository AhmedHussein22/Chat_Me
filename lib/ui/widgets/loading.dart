import 'package:chat_me/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: BLUE_COLOR,
          
        ),
        width: 100,
        height: 100,
        padding: EdgeInsets.all(25
        ),
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
