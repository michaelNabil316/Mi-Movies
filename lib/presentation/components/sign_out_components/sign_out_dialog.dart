import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

signOutDialog(
    {required BuildContext context, required Widget confirmWidget}) async {
  try {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: CupertinoAlertDialog(
              title: const Text('Do You LogOut ?'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text(
                    'Cencel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    // Dismiss the dialog but don't
                    // dismiss the swiped item
                    return Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Confirm'),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => confirmWidget));
                  },
                ),
              ],
            ),
          );
        });
  } catch (e) {
    log('Exception - profileScreen.dart - exitAppDialog(): $e');
  }
}
