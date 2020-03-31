import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/storeoutlist_model.dart';
import 'package:flutter_project1/page/main/home/account/account_receive_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/storeoutlist_vmodel.dart';
import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/custom_modal_sheet.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/slidebtn_widget.dart';

import 'storeoutadd_page.dart';

class StoreOutlayPage extends StatefulWidget {
  @override
  _StoreOutlayPageState createState() => _StoreOutlayPageState();
}

class _StoreOutlayPageState extends State<StoreOutlayPage> {
  StoreOutListVModel _storeOutListVModel = StoreOutListVModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarView(
        title: '门店支出',
      ),
      body: Container(
          color: AppColors.color_f4f4f4,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              _buildchooseTime(),
              Expanded(
                child: LoadingContainer<StoreOutListVModel>(
                    successChild: (data) {
                      _storeOutListVModel = data;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          StoreOutListModel subModel = data.list[index];
                          var key = GlobalKey<SlideButtonState>();
                          return Container(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: SlideButton(
                                  child: Container(
                                      height: Screen.h(65),
                                      color: AppColors.color_ffffff,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  subModel.costDesc,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .color_212121,
                                                      fontSize: Screen.sp(16)),
                                                ),
                                                Text(
                                                  subModel.costTime,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .color_999999,
                                                      fontSize: Screen.sp(14)),
                                                )
                                              ],
                                            ),
                                            Text(
                                              '¥${subModel.costPrice}',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.color_maincolor,
                                                  fontSize: Screen.sp(16)),
                                            )
                                          ],
                                        ),
                                      )),
                                  key: key,
                                  singleButtonWidth: Screen.w(70),
                                  buttons: <Widget>[
                                    buildAction(key, "删除", Colors.red, () {
                                      MyAlertDialog.showAlertDialog(
                                          context, '确定删除吗？', () {
                                        key.currentState.close();
                                        data.selectStoreCostId =
                                            subModel.id.toString();
                                        data.deleteStoreOut();
                                      });
                                    }),
                                  ]),
                            ),
                          );
                        },
                        itemCount: data.list.length,
                      );
                    },
                    outRefreshChild: (data, refresh) {
                      double total = 0.0;
                      for (StoreOutListModel subModel in data.list) {
                        total = subModel.costPrice + total;
                      }
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 140,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.color_maincolor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '支出',
                                          style: TextStyle(
                                              color: AppColors.color_ffffff,
                                              fontSize: 13),
                                        ),
                                        Text('¥${total.toString()}',
                                            style: TextStyle(
                                                color: AppColors.color_ffffff,
                                                fontSize: 33,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(child: refresh),
                          Container(
                              height: 80,
                              child: Center(
                                child: NormalBtnWidget(
                                  title: '记一笔',
                                  width: 300,
                                  height: 50,
                                  tap: () {
                                    if (data.list.length > 0) {
                                      NavigatorUtil.getValuePush(
                                          context,
                                          StoreoutAddPage(
                                            storeOutId: data.list[0].storeId,
                                          )).then((value) {
                                        data.initData();
                                      });
                                    }
                                  },
                                ),
                              ))
                        ],
                      );
                    },
                    refreshType: RefreshType.withwidget,
                    model: StoreOutListVModel()),
                flex: 1,
              ),
            ],
          ))),
    );
  }

  Widget _buildchooseTime() {
    return new Container(
      height: Screen.h(56),
      color: AppColors.color_ffffff,
      child: Center(
        child: Container(
          width: Screen.w(250),
          height: Screen.h(32),
          decoration: BoxDecoration(
              color: AppColors.color_f5f5f5,
              borderRadius: BorderRadius.all(Radius.circular(Screen.h(16)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Text(_storeOutListVModel.startTime),
                onTap: () {
                  DatePicker.showDatePicker(context, locale: LocaleType.zh,
                      onConfirm: (DateTime time) {
                    setState(() {
                      _storeOutListVModel.setStartTime(time);
                    });
                  });
                },
              ),
              Text('至'),
              GestureDetector(
                child: Text(_storeOutListVModel.endTime),
                onTap: () {
                  DatePicker.showDatePicker(context,
                      locale: LocaleType.zh,
                      minTime:
                          DateUtil.getDateTime(_storeOutListVModel.startTime),
                      onConfirm: (DateTime time) {
                    setState(() {
                      _storeOutListVModel.setEndTime(time);
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
    GestureTapCallback tap) {
  return InkWell(
    onTap: tap,
    child: Container(
      alignment: Alignment.center,
      width: Screen.w(70),
      color: color,
      child: Text(text,
          style: TextStyle(
            color: Colors.white,
          )),
    ),
  );
}
