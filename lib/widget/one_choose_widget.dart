import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';

/// 单选功能
class OneChooseWidget extends StatelessWidget {
  final String title;
  final List data;
  final Function callBack;

  OneChooseWidget({Key key, this.title, this.data, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: Screen.h(900),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new ListTile(
              title: new Text(
                title,
                style: new TextStyle(color: AppColors.color_434343),
              ),
            ),
            alignment: Alignment.topLeft,
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(data[index] ?? ''),
                    onTap: () {
                      callBack(data[index], index);
                      Navigator.of(context).pop();
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
