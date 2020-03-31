import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';

class MemShipCategoryHeaderWidget extends StatefulWidget {
  final String headerStr;
  final GestureTapCallback leftBtnCallBack;
  final GestureTapCallback rightBtnCallBack;
  final bool isMust;
  final bool hideAfterBtn;

  MemShipCategoryHeaderWidget(
      {Key key,
      this.headerStr,
      this.leftBtnCallBack,
      this.rightBtnCallBack,
      this.isMust = false,
      this.hideAfterBtn = false})
      : super(key: key);

  @override
  _MemShipCategoryHeaderWidgetState createState() {
    return _MemShipCategoryHeaderWidgetState();
  }
}

class _MemShipCategoryHeaderWidgetState
    extends State<MemShipCategoryHeaderWidget> {
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
      height: 45,
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: widget.isMust
                  ? _richText(widget.headerStr)
                  : Text(
                      widget.headerStr,
                      style: TextStyle(fontSize: Screen.sp(15)),
                    ),
            ),
            flex: 1,
          ),
          Visibility(
            child: Container(
                width: 100,
                height: 30,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: MyAutoBtn(
                      title: '添加现金',
                      textFontSize: Screen.sp(12),
                      backColor: AppColors.color_fbecec,
                      textColor: AppColors.color_f73b42,
                      circle: 22.5,
                      onPressed: () {
                        widget.leftBtnCallBack();
                      }),
                )),
            visible: !widget.hideAfterBtn,
          ),
          Visibility(
            child: Container(
                width: 100,
                height: 30,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: MyAutoBtn(
                      title: '添加项目',
                      textFontSize: Screen.sp(12),
                      backColor: AppColors.color_fbecec,
                      textColor: AppColors.color_f73b42,
                      circle: 22.5,
                      onPressed: () {
                        widget.rightBtnCallBack();
                      }),
                )),
            visible: !widget.hideAfterBtn,
          )
        ],
      ),
    );
  }

  Widget _richText(String text) {
    return RichText(
        text: TextSpan(
            text: text,
            style: TextStyle(
                color: AppColors.color_212121, fontSize: Screen.sp(15)),
            children: <TextSpan>[
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red),
          )
        ]));
  }
}
