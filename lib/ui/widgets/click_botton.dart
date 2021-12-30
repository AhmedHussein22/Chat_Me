import 'package:chat_me/utils/colors.dart';
import 'package:flutter/material.dart';

class ClickButton extends StatelessWidget {
 final String text ;
 final Function onPressed ;
 final double width ;
 final double height ;
 final BoxDecoration decoration;
 final Color textColor ;
 final bool loading ;

  ClickButton({this.text, this.onPressed, this.width, this.height ,this.decoration ,this.textColor,this.loading =false });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        width:width??double.infinity,
        height:height??55,
        decoration: decoration ?? BoxDecoration(
          color: BLUE_COLOR,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(text??"",
          style: theme.textTheme.headline1.copyWith(
            color: WHITE_COLOR
          ),
          ),
        ),
      ),
    );
  }
}
