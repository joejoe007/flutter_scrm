import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';

class PayWayWidget extends StatefulWidget {
  final GetBackValue getBackValue;
  final String headTitle;
  PayWayWidget({Key key,this.headTitle = '选择支付方式',this.getBackValue}) : super(key: key);

  @override
  _PayWayWidgetState createState() {
    return _PayWayWidgetState();
  }
}

class _PayWayWidgetState extends State<PayWayWidget> {
  List _list = [true, false, false, false];
  int selectTag = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: Screen.h(255),
        decoration: BoxDecoration(
            color: AppColors.color_f4f4f4,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: AppColors.color_ffffff,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                height: Screen.h(40),
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Text(
                      widget.headTitle,
                      style: TextStyle(
                          fontSize: Screen.sp(17), fontWeight: FontWeight.bold),
                    )),
                    Positioned(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text('取消'),
                          )),
                      right: 10,
                      height: Screen.h(40),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.color_f4f4f4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildPayWayWidget(0),
                      _buildPayWayWidget(1),
                      _buildPayWayWidget(2),
                      _buildPayWayWidget(3),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Container(
                  color: AppColors.color_f4f4f4,
                  height: 70,
                  child: Center(
                    child: NormalBtnWidget(
                      tap: () { /// 1 微信 2 支付宝 3 现金 4 银联
                        Navigator.of(context).pop();
                        widget.getBackValue(selectTag == 0? 1:selectTag == 1?2:selectTag == 2?3:4);
                      },
                      title: '确定',
                      width: 300,
                      height: 50,
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget _buildPayWayWidget(int tag) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < _list.length; i++) {
            if(i == tag) {
              _list[i] = true;
              selectTag = i;
            }else {
              _list[i] = false;
            }
          }
        });
      },
      child: Container(
          width: 65,
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 33,
                  height: 33,
                  child: Stack(
                    children: <Widget>[
                      Image(
                          image: AssetImage((tag == 0)
                              ? AppImages.weixinImg
                              : (tag == 1)
                                  ? AppImages.alipayImg
                                  : (tag == 2)
                                      ? AppImages.yellowCashImg
                                      : AppImages.unionPayImg)),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Visibility(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: AppColors.color_f73b42,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            visible: _list[tag],
                          ))
                    ],
                  ),
                ),
                Text(
                  (tag == 0)
                      ? '微信支付'
                      : (tag == 1) ? '支付宝支付' : (tag == 2) ? '现金支付' : '银联支付',
                  style: TextStyle(color: AppColors.color_999999, fontSize: 12),
                ),
              ],
            ),
          )),
    );
  }
}
