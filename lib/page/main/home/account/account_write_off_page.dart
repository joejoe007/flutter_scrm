import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/account_receive_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/round_check_box.dart';
import 'package:quiver/strings.dart';

import 'account_off_submit_page.dart';

class AccountWriteOffPage extends StatefulWidget {
  dynamic customerId;
  dynamic customerMoney;

  AccountWriteOffPage({this.customerId, this.customerMoney});

  @override
  _AccountWriteOffPageState createState() => _AccountWriteOffPageState();
}

class _AccountWriteOffPageState extends State<AccountWriteOffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarView(title: '销账'),
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.color_f4f4f4,
      body: SafeArea(
        child: LoadingContainer<AccountWriteOffVModel>(
          successChild: (model) {
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: Screen.w(12)),
                  padding: EdgeInsets.all(Screen.w(12)),
                  decoration: BoxDecoration(
                      color: AppColors.color_ffffff,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Text(
                            '合计欠款',
                            style: CStyle.style(AppColors.color_212121, 13),
                          ),
                          DividerUtil.VDivider(Screen.w(12)),
                          Text('¥' + StringUtil.checkEmpty(widget.customerMoney?.toString(), '0'),
                            style: CStyle.style(AppColors.color_ff3c48, 16),
                          ),
                        ],
                      )),
                      Text(
                        '全选',
                        style: CStyle.style(AppColors.color_999999, 14),
                      ),
                      DividerUtil.VDivider(Screen.w(12)),
                      Container(
                        child: RoundCheckBox(
                            value: model.checkAll,
                            onChanged: (value) {
                              model.checkAllList(value);
                            }),
                      )
                    ],
                  ),
                ),
                DividerUtil.HDivider(Screen.w(12)),
                Expanded(
                    child: ListView.separated(
                  itemCount: model.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: item(context, index, model),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return DividerUtil.HDivider(Screen.h(8));
                  },
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
                        '销账金额: ' + model.getChooseMoney(),
                        style: CStyle.style(AppColors.color_212121, 13),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AutoMakeLayoutWidget(
                            check: double.parse(model.getChooseMoney()) > 0,
                            gestureTapCallback: () {
                              NavigatorUtil.push(
                                  context,
                                  AccountOffSubmitPage(
                                    customerId: model.customerId,
                                    totalMoney: model.getChooseMoney(),
                                    accountList: model.getChooseList(),
                                  ));
                            },
                            width: Screen.w(75),
                            height: Screen.h(30),
                            bgCircle: 17,
                            bgColor: AppColors.color_ff3b25,
                            child: Text(
                              '下一步',
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
          model: AccountWriteOffVModel(customerId: widget.customerId),
        ),
      ),
    );
  }

  Widget item(BuildContext context, int index, AccountWriteOffVModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Text(
                      StringUtil.checkEmpty(model.list[index]?.orderTime?.toString()),
                      style: CStyle.style(AppColors.color_333333, 16),
                    ),
                  ],
                )),
                Container(
                  child: RoundCheckBox(
                      value: model.list[index].check,
                      onChanged: (value) {
                        setState(() {
                          model.list[index].check = value;
                        });
                        model.checkListState(value);
                      }),
                )
              ],
            ),
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              children: <Widget>[
                Container(
                    height: Screen.w(57),
                    width: Screen.w(57),
                    child: CircleAvatar(
                        child: Text(
                          StringUtil.checkEmpty(model.list[index]?.carNo?.toString(),'未').substring(0, 1),
                          style: TextStyle(
                              fontSize: Screen.sp(20),
                              color: AppColors.color_ffffff,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: AppColors.color_fbbe50)),
                DividerUtil.VDivider(Screen.w(12)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      StringUtil.checkEmpty(model.list[index]?.carNo?.toString()),
                      style: CStyle.style(AppColors.color_212121, 16),
                    ),
                    DividerUtil.HDivider(Screen.h(12)),
                    Row(
                      children: <Widget>[
                        Text(
                          _getItems(StringUtil.checkEmpty(model.list[index]?.itemNames?.toString())),
                          style: CStyle.style(AppColors.color_999999, 14),
                        ),
                        Expanded(
                          child: Text(
                            '挂账：¥' + StringUtil.checkEmpty(model.list[index]?.creditMoney?.toString()),
                            textAlign: TextAlign.end,
                            style: CStyle.style(AppColors.color_ff3c48, 16),
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
      color: AppColors.color_ffffff,
    );
  }

  String _getItems(String names) {
    if (isEmpty(names)) return '';
    List<String> stringList = names.split(',');
    if (stringList.length == 0) return '';
    if (stringList.length == 1) return stringList[0].toString();
    return stringList[0].toString() + '等' + stringList.length.toString() + '项';
  }
}
