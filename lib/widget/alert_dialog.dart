import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:quiver/strings.dart';

class MyAlertDialog {
  static void showAlertDialog(
      BuildContext context, String content, VoidCallback sure,{VoidCallback cancel, String title = '', bool canPop = true}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
            title: Text(title),
            content: Text(content,style: TextStyle(fontSize: 16),),
            actions: <Widget>[

              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  cancel();
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  sure();
                  if(canPop)
                    Navigator.of(context).pop();
                },
              ),
            ],
          );

          return (Platform.isIOS)
              ? cupertinoAlertDialog
              : AlertDialog(
                  content: Text(content),
                  title: Visibility(
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(
                          color: AppColors.color_333333,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                    visible: isNotEmpty(title),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          sure();
                          if(canPop)
                            Navigator.of(context).pop();
                        },
                        child: Text('确定')),
                    FlatButton(
                        onPressed: () {
                          cancel();
                          Navigator.of(context).pop();
                        },
                        child: Text('取消')),
                  ],
                );
        });
  }
}


