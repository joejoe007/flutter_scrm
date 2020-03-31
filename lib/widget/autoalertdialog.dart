import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoAlertDialog {
  static void showAlertDialog(BuildContext context, Widget centerWidget,
      VoidCallback sure, [String title = '']) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
            title: Text(title),
            content: centerWidget,
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  sure();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
          return cupertinoAlertDialog;
        });
  }
}