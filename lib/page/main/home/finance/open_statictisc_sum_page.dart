import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/finance_model.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/finance_statictisc_vmodel.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class OpenStatisticSumPage extends StatefulWidget {

  String begin, end;

  OpenStatisticSumPage({this.begin, this.end});

  @override
  _OpenStatisticSumPageState createState() => _OpenStatisticSumPageState();
}

class _OpenStatisticSumPageState extends State<OpenStatisticSumPage> {
  OpenStatisticSumVModel _openStatisticSumVModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarView(
          title: '营业金额',
          showBottomLine: false,
        ),
        backgroundColor: AppColors.color_f4f4f4,
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(Screen.w(12)),
                color: AppColors.color_ffffff,
                child: Center(
                  child: Container(
                    width: Screen.w(250),
                    decoration: BoxDecoration(
                      color: AppColors.color_f5f5f5,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(16)),
                    ),
                    padding:
                        EdgeInsets.fromLTRB(0, Screen.w(5), 0, Screen.w(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Text(
                            StringUtil.checkEmpty(_openStatisticSumVModel?.begin?.toString(), widget.begin.toString()),
                            style: CStyle.style(AppColors.color_434343, 15),
                          ),
                          onTap: () {
                            CommonWidgetUtil.chooseTime(
                                context, DateTime(1900, 1, 1), DateTime.now(),
                                (time) {
                              _openStatisticSumVModel.setRangeTime(
                                  startTime: time);
                              setState(() {});
                            });
                          },
                        ),
                        Text(
                          ' 至 ',
                          style: CStyle.style(AppColors.color_434343, 15),
                        ),
                        GestureDetector(
                          child: Text(
                            StringUtil.checkEmpty(_openStatisticSumVModel?.end?.toString(), widget.end.toString()),
                            style: CStyle.style(AppColors.color_434343, 15),
                          ),
                          onTap: () {
                            CommonWidgetUtil.chooseTime(
                                context, DateTime(1900, 1, 1), DateTime.now(),
                                (time) {
                              _openStatisticSumVModel.setRangeTime(
                                  endTime: time);
                              setState(() {});
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: LoadingContainer<OpenStatisticSumVModel>(
                  refreshType: RefreshType.withwidget,
                  onModelReady: (model) {
                    _openStatisticSumVModel = model;
                  },
                  outRefreshChild: (model, easy) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: Screen.h(120),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: LinearGradient(colors: [
                                AppColors.color_fb5f65,
                                AppColors.color_f73b42
                              ])),
                          margin: EdgeInsets.all(Screen.w(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '实收金额',
                                    style: CStyle.style(
                                        AppColors.color_ffffff, 13),
                                  ),
                                  DividerUtil.HDivider(Screen.h(10)),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '¥',
                                        style: CStyle.style(
                                            AppColors.color_ffffff, 14),
                                      ),
                                      DividerUtil.VDivider(Screen.w(10)),
                                      Text(
                                        StringUtil.checkEmpty(_openStatisticSumVModel?.financeAccountAndTotalModel?.orderTotal?.toString(), '0'),
                                        style: CStyle.style(
                                            AppColors.color_ffffff, 33),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '订单数',
                                    style: CStyle.style(
                                        AppColors.color_ffffff, 13),
                                  ),
                                  DividerUtil.HDivider(Screen.h(10)),
                                  Text(
                                    StringUtil.checkEmpty(_openStatisticSumVModel?.financeAccountAndTotalModel?.acount?.toString(), '0'),
                                    style: CStyle.style(
                                        AppColors.color_ffffff, 33),
                                  )
                                ],
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                _realItemHeader(),
                                Expanded(
                                  child: easy,
                                )
                              ],
                            ),
                            width: Screen.w(),
                            margin: EdgeInsets.all(Screen.w(12)),
                          ),
                          scrollDirection: Axis.horizontal,
                        ))
                      ],
                    );
                  },
                  successChild: (model) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        FinanceTotalItemModel item = model.list[index];
                        return _realItem(context, index, item);
                      },
                    );
                  },
                  model: OpenStatisticSumVModel(widget.begin,widget.end)),
            )
          ],
        ));
  }
}

/// item headerr
Widget _realItemHeader() {
  return Table(
    //表格边框样式
    border: TableBorder.all(
      color: AppColors.color_666666,
    ),
    children: [
      TableRow(children: [
        titleItem('', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('订单号', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('车主', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('订单内容', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('营业额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('退款金额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('结算状态', AppColors.color_212121, AppColors.color_f5f5f5, 35),
      ]),
    ],
  );
}

/// item
Widget _realItem(BuildContext context, int index, FinanceTotalItemModel item) {
  return Table(
    //表格边框样式
    border: TableBorder(
      verticalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      horizontalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      left: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      right: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      top: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
      bottom: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
    ),
    children: [
      TableRow(children: [
        titleItem((index + 1).toString(), AppColors.color_999999,
            AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(item?.order_no?.toString()), AppColors.color_999999,
            AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(item?.car_no?.toString()) + " " + StringUtil.checkEmpty(item?.name?.toString()),
            AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(item.item_names.toString(), AppColors.color_999999,
            AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(item?.incomeMoney?.toString(), '0'), AppColors.color_999999,
            AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(item?.backMoney?.toString(), '0'), AppColors.color_999999,
            AppColors.color_ffffff, 40),
        titleItem(Order.getPayStatusName(item.pay_status),
            AppColors.color_999999, AppColors.color_ffffff, 40),
      ]),
    ],
  );
}

Widget titleItem(String title, Color textColor, Color bgColor, double height) {
  return Container(
    height: Screen.h(height),
    alignment: Alignment.center,
    color: bgColor,
    child: Text(
      title,
      style: CStyle.style(textColor, 14),
    ),
  );
}
