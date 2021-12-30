import 'package:chat_me/ui/screens/home/home.dart';
import 'package:chat_me/ui/screens/login/login.dart';
import 'package:chat_me/utils/colors.dart';
import 'package:chat_me/utils/routes.dart';
import 'package:chat_me/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Hive.initFlutter();
  await Hive.openBox('userInfo');
  var box = Hive.box('userInfo');
  var _phoneNumber = box.get('phoneNumber');
  print('phoneNumber: $_phoneNumber');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF514e81), // navigation bar color
      statusBarColor: DARK_BLUE_COLOR, // status bar color
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp(
    phoneNumber: _phoneNumber,
  ));
}

class MyApp extends StatelessWidget {
  final phoneNumber;
  const MyApp({this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Me',
      theme: themeData(),
      home: phoneNumber != null ? HomePage() : Login(),
      routes: Routes.routes,
    );
  }
}
