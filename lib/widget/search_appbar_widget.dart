import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'automake_searchbar_widget.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double elevation;
  final Widget leading;
  final String hintText;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final ITextFieldCallBack fieldCallBack;
  final Color barBackColor;
  final bool isBrightnessDark;
  String inputText;

  SearchAppBar({
    Key key,
    this.height,
    this.elevation: 0.5,
    this.leading,
    this.hintText: '请输入关键词',
    this.focusNode,
    this.inputFormatters,
    this.fieldCallBack,
    this.prefixIcon: Icons.search,
    this.barBackColor = AppColors.color_ffffff,
    this.isBrightnessDark = true,
    this.inputText = '',
  }) : super(key: key);

  @override
  _SearchAppBarState createState() {
    return _SearchAppBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
      height ?? ScreenUtil.statusBarHeight + (Platform.isIOS?44:Screen.h(44)));
}

class _SearchAppBarState extends State<SearchAppBar> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: widget.inputText,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: widget.inputText.length))));

    TextField textField = TextField(
      controller: _controller,
      keyboardType: TextInputType.text,
      focusNode: widget.focusNode,
      onChanged: (str) {
        widget.inputText = str;
        widget.fieldCallBack(widget.inputText);
      },
      onEditingComplete: () {
        widget.focusNode.unfocus();
      },
      maxLines: 1,
      inputFormatters: widget.inputFormatters,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.color_999999,
          fontSize: 16,
        ),
        prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 10.0),
            child: Icon(
              widget.prefixIcon,
              color: AppColors.color_999999,
            )),
        contentPadding: EdgeInsets.all(10.0),
        filled: true,
        fillColor: AppColors.color_f2f2f2,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45 / 2.0),
            borderSide: BorderSide.none),
      ),
    );

    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (widget.isBrightnessDark)
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Container(
        color: widget.barBackColor,
        height: widget.height ?? ScreenUtil.statusBarHeight +
            (Platform.isIOS?44:Screen.h(44)),
        child: SafeArea(
            top: true,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex:  7,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20,top: 0,bottom: 5,right: 10),
                        child: Container(
                          child: textField,
                          height: 45,
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 0,top: 0,bottom: 5,right: 0),
                        child: Text('取消',style: TextStyle(fontSize: 16),),
                        /// 水波纹无效
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
