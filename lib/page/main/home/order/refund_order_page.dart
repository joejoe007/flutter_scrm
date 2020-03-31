import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/order_vmodel.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class RefundOrderPage extends StatefulWidget {
  dynamic refundId;

  RefundOrderPage(this.refundId);

  @override
  RefundOrderPageState createState() => new RefundOrderPageState();
}

class RefundOrderPageState extends State<RefundOrderPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBarView(
        title: '退单详情',
      ),
      backgroundColor: AppColors.color_f4f4f4,
      body: SafeArea(
          child: LoadingContainer<RefundOrderVModel>(
              onModelReady: (model) {
                model.getRefundOrderList(widget.refundId);
              },
              successChild: (model) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(Screen.w(10)),
                        decoration: BoxDecoration(
                          color: AppColors.color_ffffff,
                          borderRadius: new BorderRadius.all(new Radius.circular(5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('项目名称：' + StringUtil.checkEmpty(model.refundItemList[index]?.itemName?.toString()), style: CStyle.style(AppColors.color_212121, 15),),
                            Row(
                              children: <Widget>[
                              Text('项目数量：' + StringUtil.checkEmpty(model.refundItemList[index]?.refundAmount?.toString(), '0'), style: CStyle.style(AppColors.color_212121, 15),),
                              Text('退款金额：' + StringUtil.checkEmpty(model.refundItemList[index]?.refundPrice?.toString()), style: CStyle.style(AppColors.color_212121, 15),),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: Screen.h(6),
                        color: AppColors.color_transparent,
                      );
                    },
                    itemCount: model.refundItemList.length);
              },
              model: RefundOrderVModel())),
    );
  }
}
