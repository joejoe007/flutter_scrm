import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/page/main/home/handlecard/opencardresult_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/home/setting/employeerightsset/employeerights_list_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class BackBillingPage extends StatefulWidget {

  OrderSettlementDetailModel detailModel;

  BackBillingPage(this.detailModel);

  @override
  BackBillingPageState createState() => new BackBillingPageState(detailModel);
}

class BackBillingPageState extends State<BackBillingPage> {

  OrderSettlementDetailModel detailModel;

  BackBillingPageState(this.detailModel);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBarView(
        title: '退单',
      ),
      body: SafeArea(
          child: LoadingContainer<BackBillingVModel>(
              onModelReady: (model) {
                model.setSuccess();
                model.getOrderItemList(detailModel.orderId);
                model.detailModel = detailModel;
              },
              successChild: (model) {
                return ListView(
                  children: <Widget>[
                    backBillingItemTopWidget('整单全退'),
                    Container(
                      color: AppColors.color_ffffff,
                      padding:
                          EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                      child: Column(
                        children: <Widget>[
                          backBillingItemTextFileWidget('退款金额：', StringUtil.formatNum(double.parse(StringUtil.checkEmpty(detailModel?.shouldPay, '0.0')), 2) + '元', false),
                          Divider(
                            height: Screen.h(0.5),
                          ),
                          backBillingItemTextChooseWidget('退款方式', StringUtil.checkEmpty(Order.getPayWayName(model.payWay), '请选择'), false, () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return PayWayWidget(
                                    headTitle: '请选择退款方式',
                                    getBackValue: (value) {
                                      model.setPayWay(value);
                                    },
                                  );
                                });
                          }),
                          Divider(
                            height: Screen.h(0.5),
                          ),
                          backBillingItemTextFileWidget('会员卡退回：', '会员卡' + StringUtil.checkEmpty(detailModel?.cardItemMoney, '0.0') + '  余额' + StringUtil.checkEmpty(detailModel?.balanceMoney, '0.0'), false),
                        ],
                      ),
                    ),
                    backBillingItemTopWidget('订单信息'),
                    Container(
                      color: AppColors.color_ffffff,
                      padding:
                          EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                      child: Column(
                        children: <Widget>[
                          backBillingItemTextChooseWidget(
                              '操作人', model.operator, false, () {
                                NavigatorUtil.getValuePush(context, EmployrightsListPage(isChoose: true,)).then((value){
                                  model.setOperator(value);
                                });
                          }),
                          Divider(
                            height: Screen.h(0.5),
                          ),
                          backBillingItemTextFileWidget('退卡说明：', '请输入退卡说明', true, onchange: (value){
                                model.description = value;
                          }),
                        ],
                      ),
                    ),
                    Center(
                      child: AutoMakeLayoutWidget(
                        margin: EdgeInsets.only(top: Screen.h(30)),
                        gradient: LinearGradient(colors: [
                          AppColors.color_fb5f65,
                          AppColors.color_f73b42
                        ]),
                        gestureTapCallback: () {
                          model.backBillOrder((getValue) {
                            NavigatorUtil.push(
                                context,
                                OpenCardResultPage(
                                    resultType: ResultType.backOrder));
                          });
                        },
                        child: Text('确认退单', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(17)),),
                        check: model.refundOrderModel.operator != null && model.refundOrderModel.orderId != null && model.refundOrderModel.payWay != null,
                        height: 50,
                        width: 300,
                        bgCircle: 25,
                      ),
                    ),
                  ],
                );
              },
              model: BackBillingVModel())),
    );
  }
}

/// 输入框item
Widget backBillingItemTextFileWidget(String title, String hintText, bool isEdit,
    {TextInputType keyboardType,
    List<TextInputFormatter> inputFormatters,
    ValueChanged<String> onchange}) {
  return Container(
    height: Screen.h(45),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: AppColors.color_212121, fontSize: Screen.sp(15)),
          ),
        ),
        Expanded(
          child: isEdit
              ? TextField(
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  onChanged: onchange,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: AppColors.color_dbdbdb, fontSize: Screen.sp(14)),
                  ),
                )
              : Text(
                  hintText,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: CStyle.style(AppColors.color_666666, 14),
                ),
          flex: 2,
        ),
      ],
    ),
  );
}

/// 标题头
Widget backBillingItemTopWidget(String title) {
  return Container(
    padding: EdgeInsets.only(left: Screen.w(12)),
    alignment: Alignment.centerLeft,
    height: Screen.h(45),
    child: Text(
      title,
      style: TextStyle(color: AppColors.color_212121, fontSize: Screen.sp(15)),
    ),
  );
}

/// 选择框item
Widget backBillingItemTextChooseWidget(
    String title, String text, bool isMust, Function function) {
  return Container(
      height: Screen.h(45),
      color: AppColors.color_ffffff,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.color_212121, fontSize: Screen.sp(15)),
                ),
                Visibility(
                  child: Text(
                    '*',
                    style: TextStyle(
                        color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
                  ),
                  visible: isMust,
                ),
              ],
            )),
            Text(
              text,
              style: TextStyle(
                  color: AppColors.color_999999, fontSize: Screen.sp(14)),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.color_999999,
            )
          ],
        ),
        onTap: function,
      ));
}
