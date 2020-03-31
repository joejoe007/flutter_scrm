import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreMesWidget extends StatefulWidget {
  final VoidCallback deleteCallback;
  final VoidCallback changeStatusCallback;
  final String status;
  MoreMesWidget({Key key,this.deleteCallback,this.changeStatusCallback,this.status}) : super(key: key);

  @override
  _MoreMesWidgetState createState() {
    return _MoreMesWidgetState();
  }
}

class _MoreMesWidgetState extends State<MoreMesWidget> {
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
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(onTap: () {
              Navigator.of(context).pop();
            }),
            _buildContentView(), //构建具体的对话框布局内容
          ],
        ),
      ),
    );

  }

  Widget _buildContentView() { /// Screen.h(230)-ScreenUtil.statusBarHeight
    return  Align(alignment: Alignment.topRight,
      child: Padding(padding: EdgeInsets.only(top: (Platform.isIOS)? 44:44,right: 10),child:Container(
        width:  100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: FlatButton(onPressed: (){
              widget.deleteCallback();
            }, child: Text('删除')),flex: 1,),
            Expanded(child: FlatButton(onPressed: (){
              widget.changeStatusCallback();
            }, child: Text(widget.status)),flex: 1,),
          ],
        ),
        decoration: BoxDecoration(
          color: AppColors.color_ffffff,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
                color: AppColors.color_e1e2e3,
                offset: Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0),
            /// 阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
            BoxShadow(color: AppColors.color_e1e2e3)
          ],
        ),
      ) ,),

    );

  }
}