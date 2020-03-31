import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:quiver/strings.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItemModel _orderItemModel;

  OrderItemWidget(this._orderItemModel, {Key key}) : super(key: key);

  @override
  OrderItemWidgetState createState() => new OrderItemWidgetState();
}

class OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          Screen.w(12), Screen.w(6), Screen.w(12), Screen.w(6)),
      child: Column(
        children: <Widget>[
          // 头部
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  Order.getOrderTypeName(widget._orderItemModel?.orderType),
                  style: CStyle.style(AppColors.color_212121, 16),
                )),
                Text(
                  Order.getPayStatusName(widget._orderItemModel?.payStatus),
                  style: CStyle.style(AppColors.color_ff3b25, 16),
                ),
              ],
            ),
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  Constant.TEST_IMAGE_URL,
                  width: Screen.w(45),
                  height: Screen.w(45),
                  fit: BoxFit.fill,
                ),
                DividerUtil.VDivider(Screen.w(12)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          StringUtil.checkEmpty(widget._orderItemModel?.carNo?.toString()) + ' ' + StringUtil.checkEmpty(widget._orderItemModel?.customerName?.toString()),
                          style: CStyle.style(AppColors.color_212121, 16),
                        ),
                        DividerUtil.VDivider(Screen.w(8.5)),
                        Visibility(
                          child: AutoMakeLayoutWidget(
                            width: Screen.w(35),
                            height: Screen.h(21),
                            bgCircle: 5,
                            gradient: LinearGradient(colors: [
                              AppColors.color_f2c97f,
                              AppColors.color_cb993e
                            ]),
                            child: Text(
                              'VIP',
                              style: TextStyle(
                                  color: AppColors.color_ffffff,
                                  fontSize: Screen.sp(13)),
                            ),
                          ),
                          visible: Member.boolMember(widget._orderItemModel?.customerType),
                        ),
                        Expanded(
                            child: Align(
                          child: Icon(
                            Icons.chevron_right,
                            color: AppColors.color_999999,
                          ),
                          alignment: Alignment.centerRight,
                        ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _getItems(StringUtil.checkEmpty(widget._orderItemModel?.itemNames?.toString())),
                            overflow: TextOverflow.ellipsis,
                            style: CStyle.style(AppColors.color_999999, 16),
                          ),
                        ),
                        Text('¥' + StringUtil.checkEmpty(widget._orderItemModel?.orderMoney?.toString(), '0'),
                          style: CStyle.style(AppColors.color_ff3b25, 16),
                        )
                      ],
                    ),
                    Text(
                      StringUtil.checkEmpty(widget._orderItemModel?.createTime?.toString(), '0'),
                      style: CStyle.style(AppColors.color_999999, 14),
                    )
                  ],
                )),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: AppColors.color_ffffff,
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}

String _getItems(String names) {
  if (isEmpty(names)) return '';
  List<String> stringList = names.split(',');
  if (stringList.length == 0) return '';
  if (stringList.length == 1) return stringList[0].toString();
  return stringList[0].toString() + ' 等' + stringList.length.toString() + '项';
}
