import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project1/common/api.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/repository/base/remote_repo.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/sp_util.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String _name; // 用户名
  String _pass; // 密码

  bool _isHide = true;

  FocusNode _phoneFocusNode;
  FocusNode _passFocusNode;

  @override
  void initState() {
    _phoneFocusNode = new FocusNode();
    _passFocusNode = new FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBarView(
        title: '登录',
        leftVisible: false,
      ),
      body: new Container(
          height: double.infinity,
          color:  AppColors.color_ffffff,
          child: new SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Screen.w(35.0),
                vertical: Screen.h(30.0),
              ),
              child: new Container(
                // 子属性居中
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /// 图片logo
                    new Image.asset(
                      AppImages.assetsImgLoginLogo,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),

                    /// 输入框
                    new Container(
                      margin: EdgeInsets.only(top: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '用户名',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.color_333333),
                                  ),
                                  width: 60,
                                ),
                                Expanded(
                                  child: LoginTextFieldWidget(
                                    focusNode: _phoneFocusNode,
                                    hitString: '请输入您的用户名',
                                    keyboardType: ITextInputType.text,
                                    fieldCallBack: (content) {
                                      _name = content;
                                    },
                                  ),
                                  flex: 1,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.color_d8d8d8,
                                        width: 1.0))),
                          ),
                          new Container(
                            height: Screen.h(20),
                          ),
                          new Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '密     码',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.color_333333),
                                  ),
                                  width: 60,
                                ),
                                Expanded(
                                  child: LoginTextFieldWidget(
                                    focusNode: _passFocusNode,
                                    hitString: '请输入密码',
                                    keyboardType: ITextInputType.password,
                                    ishidePwd: _isHide,
                                    fieldCallBack: (content) {
                                      _pass = content;
                                    },
                                  ),
                                  flex: 1,
                                ),
                                Container(
                                  child: IconButton(
                                      icon: !_isHide
                                          ? Icon(
                                        Icons.visibility,
                                        color: AppColors.color_999999,
                                      )
                                          : Icon(Icons.visibility_off, color: AppColors.color_999999,),
                                      onPressed: () {
                                        setState(() {
                                          _isHide = !_isHide;
                                        });
                                      }),
                                  width: 40,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.color_d8d8d8,
                                        width: 1.0))),
                          )
                        ],
                      ),
                    ),

                    /// 底部确认按钮
                    new Container(
                      margin: EdgeInsets.only(top: 100),
                      width: 300,
                      height: 45,
                      child: new FlatButton(
                        color: AppColors.color_999999,
                        highlightColor: AppColors.color_999999,
                        colorBrightness: Brightness.dark,
                        splashColor: AppColors.color_ffffff,
                        child: Text(
                          '登录',
                          style: new TextStyle(
                              color: AppColors.color_ffffff, fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          hideFocus();
//                          RegExp _phoneReg = RegExp(
//                              r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
//                          if (null == _name || _name.isEmpty) {
//                            MyToast.showToast('请输入手机号码');
//                            return;
//                          }
//                          if (null == _name || _name.isEmpty) {
//                            MyToast.showToast('请输入手机号码');
//                            return;
//                          }
//                          if (null == _pass || _pass.isEmpty) {
//                            MyToast.showToast('请输入密码');
//                            return;
//                          }
//                          doLogin(context);
                          NavigatorUtil.push(context, new MainPage());
                        },
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }


  doLogin(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      int currentNumber = int.parse(packageInfo.buildNumber); //获取当前的版本号
      Map<String, dynamic> _params = Map();
      _params['userName'] = '881147210';
      _params['password'] = '12345678';
//      _params['userName'] = _name;
//      _params['password'] = _pass;
      _params['channel'] = Platform.isIOS ? 1 : 2;
      _params['verifyCode'] = currentNumber;
      RepositoryCommon.login(_params).then((result) {
        NavigatorUtil.push(context, new MainPage());
      });
    });
  }

  /// 失去焦点
  hideFocus() {
    /// 失去焦点
    _phoneFocusNode.unfocus();
    _passFocusNode.unfocus();
  }
}

/// 输入框
enum ITextInputType { phone, password, text }

typedef void ITextFieldCallBack(String content);

class LoginTextFieldWidget extends StatefulWidget {
  final ITextInputType keyboardType;
  final FocusNode focusNode;
  final String hitString;
  final ITextFieldCallBack fieldCallBack;
  final bool ishidePwd;

  LoginTextFieldWidget(
      {Key key,
        this.keyboardType: ITextInputType.phone,
        this.focusNode,
        this.hitString,
        this.fieldCallBack,
        this.ishidePwd = true})
      : super(key: key);

  @override
  _LoginTextFieldWidgetState createState() {
    return _LoginTextFieldWidgetState();
  }
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  String _inputText = '';
  bool _hasdeleteIcon = false;
  bool _isPassword = false;

  TextInputType _getTextInput() {
    switch (widget.keyboardType) {
      case ITextInputType.phone:
        return TextInputType.phone;
        break;

      case ITextInputType.password:
        _isPassword = true;
        return TextInputType.text;
        break;
      case ITextInputType.text:
        return TextInputType.text;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    TextField textField = new TextField(
      controller: _controller,
      keyboardType: _getTextInput(),
      focusNode: widget.focusNode,
      onTap: () {
        _hasdeleteIcon = _inputText.isNotEmpty ? true : false;
      },
      onChanged: (str) {
        setState(() {
          _inputText = str;
          _hasdeleteIcon = (_inputText.isNotEmpty);
          widget.fieldCallBack(_inputText);
        });
      },
      onEditingComplete: () {
        _hasdeleteIcon = false;
        widget.focusNode.unfocus();
      },
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: widget.hitString,
        hintStyle: new TextStyle(
          color: AppColors.color_a8a8a8,
          fontSize: 15,
        ),
        suffixIcon: _hasdeleteIcon
            ? new Container(
          width: 20.0,
          height: 20.0,
          child: new IconButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.0),
            iconSize: 18.0,
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                _inputText = "";
                _hasdeleteIcon = (_inputText.isNotEmpty);
                widget.fieldCallBack(_inputText);
              });
            },
          ),
        )
            : new Text(""),
      ),
      obscureText: (_isPassword && widget.ishidePwd) ? true : false,
    );
    // TODO: implement build
    return textField;
  }
}
