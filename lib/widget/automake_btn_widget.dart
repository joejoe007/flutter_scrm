import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';

class MyAutoBtn extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String title;
  final Color backColor;
  final Color textColor;
  final Color borderColor;
  final bool isHaveBorder;
  final double circle;
  final double textFontSize;
  final String iconStr;

  MyAutoBtn(
      {Key key,
      this.onPressed,
      this.title,
      this.backColor = AppColors.color_999999,
      this.textColor = AppColors.color_ffffff,
      this.borderColor = AppColors.color_f73b42,
      this.isHaveBorder = false,
      this.circle = 2.0,
      this.textFontSize,
      this.iconStr})
      : super(key: key);

  @override
  _MyAutoBtnState createState() {
    return _MyAutoBtnState();
  }
}

class _MyAutoBtnState extends State<MyAutoBtn> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    OutlineButton btn = OutlineButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.title,
        style:
            TextStyle(fontSize: widget.textFontSize, color: widget.textColor),
      ),
      borderSide: BorderSide(color: widget.borderColor),
      highlightedBorderColor: widget.borderColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.circle)),
    );

    // TODO: implement build
    return widget.isHaveBorder
        ? btn
        : FlatButton(
            onPressed: widget.onPressed,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: widget.textFontSize),
            ),
            color: widget.backColor,
            highlightColor: widget.backColor,
            textColor: widget.textColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.circle)),
          );
  }
}
