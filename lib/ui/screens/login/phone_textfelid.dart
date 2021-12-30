import 'package:chat_me/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextfelid extends StatelessWidget {
  final ValueChanged<PhoneNumber> onChanged;

  const PhoneTextfelid({
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return IntlPhoneField(
       initialCountryCode: "EG",
        style: theme.textTheme.headline2,
        countryCodeTextColor: DARK_BLUE_COLOR,
        autoValidate: true,
         maxLength: 10,
        // validator: (value) => value.toString().isEmpty
        //     ? "Please enter a valid phone number"
        //     : null,
        decoration: InputDecoration(
          hintText: "Phone Number",
          errorStyle: theme.textTheme.bodyText1.copyWith(color: RED_COLOR),
          hintStyle: theme.textTheme.bodyText1,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: BLUE_COLOR, width: 1.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: BLUE_COLOR, width: 1.5),
          ),
        ),
        onChanged: onChanged,
        );
  }
}
