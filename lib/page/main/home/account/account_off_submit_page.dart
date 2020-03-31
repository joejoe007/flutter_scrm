import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/account_receiver_model.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/account_receive_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

class AccountOffSubmitPage extends StatefulWidget {
  dynamic customerId;
  dynamic totalMoney;
  List<AccountConsumeItemModel> accountList = [];

  AccountOffSubmitPage({this.customerId, this.totalMoney, this.accountList});

  @override
  _AccountOffSubmitPageState createState() => _AccountOffSubmitPageState();
}

class _AccountOffSubmitPageState extends State<AccountOffSubmitPage> {

  TextEditingController textController = TextEditingController();
  AccountSubmitVModel model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarView(title: '销账'),
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.color_f4f4f4,
      body: SafeArea(
        child: LoadingContainer<AccountSubmitVModel>(
          onModelReady: (model) {
            this.model = model;
            model.setSuccess();
          },
          successChild: (model) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '结算信息',
                        style: CStyle.style(AppColors.color_212121, 13),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(Screen.w(12)),
                    ),
                    Container(
                      height: Screen.h(45),
                      padding:
                          EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                      color: AppColors.color_ffffff,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '销账金额',
                              style: CStyle.style(AppColors.color_212121, 14),
                            ),
                          ),
                          Text(
                            '¥' + StringUtil.checkEmpty(widget.totalMoney?.toString(), '0'),
                            style: CStyle.style(AppColors.color_ff3c48, 16),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: Screen.h(0.5),
                    ),
                    Container(
                      height: Screen.h(45),
                      color: AppColors.color_ffffff,
                      padding:
                          EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '优惠金额',
                              style: CStyle.style(AppColors.color_212121, 14),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if(isEmpty(value.toString())) {
                                  model.discountMoney = value;
                                  return;
                                }
                                if (double.parse(value.toString()) > double.parse(widget.totalMoney.toString())) {
                                  MyToast.showToast('优惠金额不能大于销帐金额');
                                  textController.text = '';
                                  model.discountMoney = 0;
                                  return;
                                }
                                model.discountMoney = value;
                              },
                              keyboardType: TextInputType.number,
                              controller: textController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入',
                                hintStyle: TextStyle(
                                    color: AppColors.color_dbdbdb,
                                    fontSize: Screen.sp(14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DividerUtil.HDivider(Screen.w(12)),
                    GestureDetector(
                      child: Container(
                        height: Screen.h(45),
                        color: AppColors.color_ffffff,
                        padding: EdgeInsets.fromLTRB(
                            Screen.w(12), 0, Screen.w(12), 0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '收款方式',
                                style: CStyle.style(AppColors.color_212121, 14),
                              ),
                            ),
                            Text(
                              isEmpty(model.payType.toString()) ? '请选择' : Order.getPayWayName(model.payType),
                              style: CStyle.style(AppColors.color_212121, 14),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.color_999999,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: AppColors.color_transparent,
                            context: context,
                            builder: (BuildContext dialogContex) {
                              return PayWayWidget(
                                getBackValue: ((payType) async {
                                  print('支付' + payType.toString());
                                  await model.setPayType(payType);
                                }),
                              );
                            });
                      },
                    )
                  ],
                )),
                Container(
                  color: AppColors.color_ffffff,
                  height: Screen.h(50),
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '应收：' + (double.parse(StringUtil.checkEmpty(model.totalMoney?.toString(),'0')) - double.parse(StringUtil.checkEmpty(model.discountMoney?.toString(),'0'))).toString(),
                        style: CStyle.style(AppColors.color_212121, 13),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AutoMakeLayoutWidget(
                            gestureTapCallback: () {
                              model.submitAccount(context);
                            },
                            width: Screen.w(75),
                            height: Screen.h(30),
                            bgCircle: 17,
                            check: double.parse(StringUtil.checkEmpty(model.discountMoney?.toString(),'0')) > 0,
                            bgColor: AppColors.color_ff3b25,
                            child: Text(
                              '提交',
                              style: CStyle.style(AppColors.color_ffffff, 14),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
          model: AccountSubmitVModel(
              customerId: widget.customerId,
              totalMoney: widget.totalMoney,
              accountList: widget.accountList),
        ),
      ),
    );
  }
}
