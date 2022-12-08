import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/presentation/screens/movies_list_screen.dart';
import 'package:pharma_tv/shared/cashHelper/chash_helper.dart';
import 'package:pharma_tv/shared/navigate.dart';

import '../../shared/styels.dart';
import '../components/home_componenbts/home_appbar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightPrimeColor,
      appBar: customAppBar(title: "Mi Movie", context: context),
      body: Column(
        children: [
          Container(
            decoration: cardDecoration,
            width: width,
            height: height * 0.2,
            margin: EdgeInsets.all(50.w),
            child: Center(
              child: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                  text: 'Hello, ',
                  style: boldTxt,
                ),
                TextSpan(
                  text: CashHelper.getData(key: 'name'),
                  style: boldTxtAmber,
                ),
              ])),
            ),
          ),
          GestureDetector(
            child: Container(
              width: width,
              height: height * 0.2,
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              decoration: cardDecoration,
              child: Center(
                  child: Text(
                "Go to movies",
                style: boldTxt,
              )),
            ),
            onTap: () {
              navigateTo(context, MoviesListScreen());
            },
          ),
        ],
      ),
    );
  }
}
