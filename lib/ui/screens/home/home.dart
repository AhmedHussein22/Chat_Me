import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String phone;

  const HomePage({Key key, this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      
    );
  }
}