import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';

import 'automake_btn_widget.dart';

class NormalBtnWidget extends StatefulWidget {
  final String title;
  final GestureTapCallback tap;
  final double height;
  final double width;

  NormalBtnWidget({Key key, this.title, this.tap, this.height, this.width}) : super(key: key);

  @override
  _NormalBtnWidgetState createState() {
    return _NormalBtnWidgetState();
  }
}

class _NormalBtnWidgetState extends State<NormalBtnWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.color_fb5f65, AppColors.color_f73b42]),
          borderRadius: BorderRadius.circular(widget.height/2)),
      child: MyAutoBtn(
          title: widget.title,
          textFontSize: Screen.sp(17),
          textColor: AppColors.color_ffffff,
          backColor: Colors.transparent,
          onPressed: widget.tap),
    );
  }
}
