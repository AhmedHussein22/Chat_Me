import 'package:chat_me/services/api.dart';
import 'package:chat_me/ui/screens/login/otp.dart';
import 'package:chat_me/ui/screens/login/phone_textfelid.dart';
import 'package:chat_me/ui/widgets/click_botton.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _phone = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Enter your phone number to get started",
                  style: theme.textTheme.headline1.copyWith(fontSize: 24),
                ),
                SizedBox(height: 15),
                PhoneTextfelid(
                
                  onChanged: (PhoneNumber phoneNumber) {
                    print(phoneNumber.completeNumber);
                    setState(() {
                      _phone = phoneNumber.completeNumber;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClickButton(
          text: "Next",
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OTPScreen(_phone)));
            }
          },
        ),
      ),
    );
  }
}
