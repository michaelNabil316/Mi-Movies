import 'package:flutter/material.dart';
import 'package:pharma_tv/presentation/screens/home_screen.dart';
import 'package:pharma_tv/shared/cashHelper/chash_helper.dart';
import 'package:pharma_tv/shared/navigate.dart';

import '../../shared/styels.dart';
import '../components/home_componenbts/home_appbar.dart';

//welcome screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPrimeColor,
      appBar: CustomAppBar(title: "Mi Movie"),
      body: Column(
        children: [
          Text("Hello, ${CashHelper.getData(key: 'key')}"),
          GestureDetector(
            child: Text("Go to movies"),
            onTap: () {
              navigateTo(context, MoviesListScreen());
            },
          ),
        ],
      ),
    );
  }
}
