import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:quiver/strings.dart';

class CustomerListWidget extends StatefulWidget {

  CustomerInfoModel _customerInfo;

  CustomerListWidget(this._customerInfo, {Key key}) : super(key: key);

  @override
  CustomerListWidgetState createState() => new CustomerListWidgetState(_customerInfo);
}

class CustomerListWidgetState extends State<CustomerListWidget> {

  CustomerInfoModel _customerInfo;

  CustomerListWidgetState(this._customerInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Screen.w(10)),
      decoration: BoxDecoration(
        color: AppColors.color_ffffff,
        borderRadius: new BorderRadius.all(new Radius.circular(5)),
      ),
      height: Screen.h(70),
      child: Row(
        children: <Widget>[
          Container(
              width: Screen.w(40),
              height: Screen.w(40),
              child: CircleAvatar(
                child: Text(
                  isEmpty(_customerInfo?.name)
                      ? ''
                      : _customerInfo.name.substring(0, 1),
                  style: TextStyle(
                      fontSize: Screen.sp(18),
                      color: AppColors.color_ffffff,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.color_83a4F1,
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Screen.w(11)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                        Text(
                          isEmpty(_customerInfo?.name?.toString()) ? '未知' : _customerInfo.name.toString() + ' ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.color_212121,
                              fontSize: Screen.sp(16)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      Expanded(
                        child: Text(
                            isEmpty(_customerInfo?.mobile?.toString()) ? '' : _customerInfo.mobile.toString(),
                            style: TextStyle(
                                color: AppColors.color_666666,
                                fontSize: Screen.sp(14)),
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                  DividerUtil.HDivider(Screen.h(3)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isEmpty(getCarNumString()) ? '' : getCarNumString(),
                      style: TextStyle(
                          color: AppColors.color_666666,
                          fontSize: Screen.sp(12)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            flex: 1,
          ),
          Center(
            child: Icon(
              Icons.chevron_right,
              color: AppColors.color_999999,
            ),
          ),
        ],
      ),
    );
  }

  /// 获取车牌号数组
  String getCarNumString() {
    String carNumString = '';
    StringBuffer carBuffer = StringBuffer();
    if (_customerInfo == null || _customerInfo.cars == null) {
      return carNumString;
    }
    for (CustomListCarModel o in _customerInfo.cars) {
      carBuffer.write(o.carNo);
      carBuffer.write(' | ');
    }
    if (carBuffer.isNotEmpty)
      carNumString =
          carBuffer.toString().substring(0, carBuffer.toString().length - 2);
    return carNumString;
  }
}
