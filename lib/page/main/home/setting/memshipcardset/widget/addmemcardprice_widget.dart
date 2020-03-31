import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';

class AddMemCardPriceWidget extends StatefulWidget {
  final String headStr;
  final String content;
  final bool isHaveDelete;
  final GestureTapCallback tap;
  final ITextFieldCallBack fieldCallBack;

  AddMemCardPriceWidget(
      {Key key,
      this.headStr,
      this.content = '',
      this.fieldCallBack,
      this.isHaveDelete = false,
      this.tap})
      : super(key: key);

  @override
  _AddMemCardPriceWidgetState createState() {
    return _AddMemCardPriceWidgetState();
  }
}

class _AddMemCardPriceWidgetState extends State<AddMemCardPriceWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(widget.headStr),
              width: 80,
            ),
            Expanded(
              child: AutoMakeSearchBar(
                blackColor: AppColors.color_transparent,
                isFromRight: true,
                isShowPrefix: false,
                fristStr: widget.content,
                fieldCallBack: (content) {
                  widget.fieldCallBack(content);
                },
              ),
              flex: 1,
            ),
            Container(
              child: Text((widget.headStr == '现金') ? '元' : '次'),
              width: 40,
            ),
            Container(
              width: widget.isHaveDelete ? 40 : 0,
              child: widget.isHaveDelete
                  ? GestureDetector(
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Image.asset(AppImages.graydelete),
                      ),
                      onTap: widget.tap,
                    )
                  : Text(''),
            )
          ],
        ),
      ),
    );
  }
}
