import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/shared/navigate.dart';
import 'package:pharma_tv/shared/styels.dart';

import '../../../shared/cashHelper/chash_helper.dart';
import '../../screens/signin_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: appBarTitleStyle),
      centerTitle: true,
      backgroundColor: primaryColor.shade300,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 30.w),
          child: GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 50.r,
              child: Icon(Icons.logout_outlined),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        await CashHelper.clearAllData();
                        navigateAndFinish(context, SigninScreen());
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
