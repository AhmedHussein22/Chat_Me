import 'package:chat_me/utils/colors.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Function validatorFun;
  final TextInputType keyboardType;

  const TextInputField({
    this.hintText,
    this.onChanged,
    this.validatorFun,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validatorFun,
      style: theme.textTheme.headline2,
      onChanged: onChanged,
      cursorColor: DARK_BLUE_COLOR,
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: theme.textTheme.bodyText1.copyWith(color: RED_COLOR),
        hintStyle: theme.textTheme.bodyText1,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: BLUE_COLOR, width: 1.5),
        ),
        enabledBorder: 
         UnderlineInputBorder(
          borderSide: BorderSide(color: BLUE_COLOR, width: 1.5),
        ),
      ),
    );
  }
}
