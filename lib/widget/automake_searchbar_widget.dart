import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';

/// 输入框
enum ITextInputType { phone, password, text, num ,decimal}

typedef void ITextFieldCallBack(String content);

class AutoMakeSearchBar extends StatefulWidget {
  final ITextInputType keyboardType;
  final ITextFieldCallBack fieldCallBack;
  final String hintText;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final double searhBarHeight;
  final bool isShowPrefix;
  final Color blackColor;
  final bool isHaveBorder;
  final bool isCanWirte;
  final TextEditingController editingController;
  final bool isFromRight;
  final double fontSize;
  final Color hintColor;

  final String fristStr;

  /// 默认值

  AutoMakeSearchBar(
      {Key key,
      this.keyboardType = ITextInputType.text,
      this.fieldCallBack,
      this.searhBarHeight = 45,
      this.focusNode,
      this.hintText = '请输入',
      this.prefixIcon = Icons.search,
      this.inputFormatters,
      this.isShowPrefix = true,
      this.blackColor = AppColors.color_f2f2f2,
      this.isHaveBorder = false,
      this.isCanWirte = true,
      this.editingController,
      this.isFromRight = false,
      this.fontSize = 16,
      this.hintColor = AppColors.color_999999,
      this.fristStr})
      : super(key: key);

  @override
  _AutoMakeSearchBarState createState() {
    return _AutoMakeSearchBarState();
  }
}

class _AutoMakeSearchBarState extends State<AutoMakeSearchBar> {
  String _inputText = '';

  TextInputType _getTextInput() {
    switch (widget.keyboardType) {
      case ITextInputType.phone:
        return TextInputType.phone;
        break;
      case ITextInputType.password:
        return TextInputType.text;
        break;
      case ITextInputType.text:
        return TextInputType.text;
        break;
      case ITextInputType.num:
        return TextInputType.number;
        break;
      case ITextInputType.decimal:
        return TextInputType.numberWithOptions(decimal: true);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.editingController != null && widget.fristStr != null) {
      widget.editingController.text = widget.fristStr;
    }
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: (widget.fristStr != null)
                ? widget.fristStr
                : _inputText,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    InputDecoration inputDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyle(
        color: widget.hintColor,
        fontSize: widget.fontSize,
      ),
      prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 10.0),
          child: Icon(
            widget.prefixIcon,
            color: AppColors.color_999999,
          )),
      contentPadding: EdgeInsets.all(10.0),
      filled: true,
      fillColor: widget.blackColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.searhBarHeight / 2.0),
        borderSide:
            widget.isHaveBorder ? BorderSide(width: 1) : BorderSide.none,
      ),
    );

    InputDecoration notincluedPrefixDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyle(
        color: widget.hintColor,
        fontSize: widget.fontSize,
      ),
      contentPadding: EdgeInsets.all(10.0),
      filled: true,
      fillColor: widget.blackColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            widget.isHaveBorder ? 4 : widget.searhBarHeight / 2.0),
        borderSide:
            widget.isHaveBorder ? BorderSide(width: 1) : BorderSide.none,
      ),
    );

    TextField textField = TextField(
      style:
          TextStyle(fontSize: widget.fontSize, color: AppColors.color_333333),
      controller: (widget.editingController != null)
          ? widget.editingController
          : _controller,
      keyboardType: _getTextInput(),
      focusNode: widget.focusNode,
      maxLines: 1,
      inputFormatters: widget.inputFormatters,
      textInputAction:
          (widget.isShowPrefix) ? TextInputAction.search : TextInputAction.done,
      decoration:
          (widget.isShowPrefix) ? inputDecoration : notincluedPrefixDecoration,
      onChanged: (str) {
        _inputText = str;
        widget.fieldCallBack(_inputText);
      },
      onSubmitted: (str) {
        _inputText = str;
        widget.fieldCallBack(_inputText);
      },
      enabled: widget.isCanWirte,
      textAlign: widget.isFromRight ? TextAlign.right : TextAlign.left,
    );

    //是否自动获得焦点
//    autofocus: false,

    // TODO: implement build
    return widget.isHaveBorder
        ? Theme(
            data: ThemeData(hintColor: AppColors.color_e1e2e3),
            child: textField)
        : textField;
  }
}
