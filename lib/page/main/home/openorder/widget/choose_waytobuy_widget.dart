import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';


class ChooseWayToBuyWidget extends StatefulWidget {

  final GetBackValue getBackValue;
  ChooseWayToBuyWidget({Key key,this.getBackValue}) : super(key: key);

  @override
  _ChooseWayToBuyWidgetState createState() {
    return _ChooseWayToBuyWidgetState();
  }
}

class _ChooseWayToBuyWidgetState extends State<ChooseWayToBuyWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: AppColors.color_ffffff,
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Center(
              child: Text('选择付款方式'),
            ),
          ),

          Expanded(child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildPayBtnWidget('支付宝', 4),/// 4
                _buildPayBtnWidget('微信', 3),/// 3
                _buildPayBtnWidget('现金', 2),/// 2
                _buildPayBtnWidget('银联', 5)/// 5
              ],
            ),
          ),flex: 1,)

        ],
      ),
    );
  }

  Widget _buildPayBtnWidget(String btnTitle, int tag) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: MyAutoBtn(
          title: btnTitle,
          textFontSize: 16,
          onPressed: () {
            widget.getBackValue({'title':btnTitle,'type':tag.toString()});
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
