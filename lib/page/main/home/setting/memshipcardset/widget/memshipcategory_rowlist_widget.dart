import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';

class MemShipCategoryRowWdiget extends StatefulWidget {
  final bool isMust;
  final String headStr;
  final String hintStr;
  final String textfStr;
  final bool isPrice;
  final String unit;
  final ITextFieldCallBack fieldCallBack;
  final ITextInputType keyboardType;
  final bool isCanWirte;
  final List<TextInputFormatter> inputFormatters;

  MemShipCategoryRowWdiget(
      {Key key,
      this.isMust = false,
      this.headStr,
      this.hintStr,
      this.isPrice = false,
      this.unit = '元',
      this.fieldCallBack,
      this.textfStr,
      this.keyboardType = ITextInputType.text,
      this.isCanWirte = true,this.inputFormatters})
      : super(key: key);

  @override
  _MemShipCategoryRowWdigetState createState() {
    return _MemShipCategoryRowWdigetState();
  }
}

class _MemShipCategoryRowWdigetState extends State<MemShipCategoryRowWdiget> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              width: 85,
              child: widget.isMust
                  ? _richText(widget.headStr)
                  : Text(
                      widget.headStr,
                      style: TextStyle(
                          color: AppColors.color_212121,
                          fontSize: Screen.sp(15)),
                    ),
            ),
          ),
          Expanded(
            child: AutoMakeSearchBar(
              inputFormatters: widget.inputFormatters,
              isCanWirte: widget.isCanWirte,
              isShowPrefix: false,
              blackColor: AppColors.color_ffffff,
              isFromRight: true,
              hintText: widget.hintStr,
              hintColor: AppColors.color_dbdbdb,
              fontSize: Screen.sp(15),
              fieldCallBack: (content) {
                widget.fieldCallBack(content);
              },
              fristStr: widget.textfStr,
              keyboardType: widget.keyboardType,
            ),
            flex: 1,
          ),
          Visibility(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(widget.unit),
              ),
            ),
            visible: widget.isPrice,
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
