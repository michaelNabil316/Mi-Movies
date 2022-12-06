import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const primaryColor = Colors.indigo;
final lightPrimeColor = Colors.indigo.shade100;

final TextStyle response14font = TextStyle(fontSize: 14.sp);
final TextStyle response16font = TextStyle(fontSize: 16.sp);
final TextStyle response18font = TextStyle(fontSize: 18.sp);
final TextStyle response22font = TextStyle(fontSize: 22.sp);
final signInStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: primaryColor);
final customThemeData = ThemeData(
  primaryColor: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: primaryColor),
    titleTextStyle: TextStyle(
        color: primaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: lightPrimeColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    actionsIconTheme: IconThemeData(color: primaryColor),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.black54,
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: primaryColor,
      overflow: TextOverflow.ellipsis,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      color: primaryColor,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
final titleTxtStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 60.sp, color: Colors.amber[800]);

final overViewTxtStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 40.sp, color: primaryColor);

final mainTitleStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 40.sp, color: Colors.amber[800]);

final detailsStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 45.sp, color: Colors.black);
final appBarTitleStyle = TextStyle(color: Colors.white, fontSize: 70.sp);
