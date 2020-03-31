import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customercare_model.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/customercare_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';


class CustomerCareListPage extends StatefulWidget {
  CustomerCareListPage({Key key}) : super(key: key);

  @override
  _CustomerCareListPageState createState() {
    return _CustomerCareListPageState();
  }
}

class _CustomerCareListPageState extends State<CustomerCareListPage> {
  CustomerCareVModel nocareVModel = CustomerCareVModel();
  CustomerCareVModel careVModel = CustomerCareVModel();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBarView(
          title: '客户关怀',
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 45,
                color: AppColors.color_ffffff,
                child: TabBar(
                  tabs: <Widget>[
                    Text(
                      '未提醒',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '已提醒',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                  indicatorColor: AppColors.color_f73b42,
                  labelColor: AppColors.color_f73b42,
                  unselectedLabelColor: AppColors.color_666666,
                  indicatorPadding: EdgeInsets.only(
                      left: Screen.w() / 8, right: Screen.w() / 8),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [_buildListWidget('0'), _buildListWidget('1')],
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListWidget(String status) {
    return Container(
      color: AppColors.color_f4f4f4,
      child: LoadingContainer<CustomerCareVModel>(
          refreshType: RefreshType.withwidget,
          autoDispose: false,
          successChild: (data) {
            if (status == 1) {
              careVModel = data;
            } else {
              nocareVModel = data;
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int position) {
                return GestureDetector(
                  child: _buildRowWidget(data.list[position]),
                  onTap: () {
                    data.setSelect(data.list[position]);
                  },
                );
              },
              itemCount: data.list.length,
            );
          },
          outRefreshChild: (data, refresh) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 45,
                    color: AppColors.color_ffffff,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '关怀类型',
                                  style: TextStyle(
                                      color: AppColors.color_666666,
                                      fontSize: 14),
                                ),
                                Icon(Icons.arrow_drop_down,
                                    color: AppColors.color_cccccc)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (status == 1) {
                                careVModel.setAllSelect(!careVModel.allSelect);
                              } else {
                                nocareVModel
                                    .setAllSelect(!nocareVModel.allSelect);
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '全选 ',
                                  style: TextStyle(
                                      color: AppColors.color_666666,
                                      fontSize: 14),
                                ),
                                Icon(
                                  (status == 1)
                                      ? ((!careVModel.allSelect)
                                          ? Icons.radio_button_unchecked
                                          : Icons.check_circle)
                                      : ((!nocareVModel.allSelect)
                                          ? Icons.radio_button_unchecked
                                          : Icons.check_circle),
                                  color: (status == 1)
                                      ? ((!careVModel.allSelect)
                                          ? AppColors.color_cccccc
                                          : AppColors.color_maincolor)
                                      : ((!nocareVModel.allSelect)
                                          ? AppColors.color_cccccc
                                          : AppColors.color_maincolor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: refresh,
                    flex: 1,
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            '优先发送公众号消息，若未关注公众号则发送短信',
                            style: TextStyle(
                                color: AppColors.color_999999, fontSize: 12),
                          ),
                        ),
                        NormalBtnWidget(
                          width: 300,
                          height: 50,
                          title: '发送提醒',
                          tap: () {
                            if (status == 1) {
                              careVModel.sendCustomerCare();
                            } else {
                              nocareVModel.sendCustomerCare();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          model: CustomerCareVModel(status: status)),
    );
  }

  Widget _buildRowWidget(CustomerCareListModel subModel) {
    return Container(
        height: 80,
        color: AppColors.color_f4f4f4,
        child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              color: AppColors.color_ffffff,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 60,
                      height: 60,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.color_fbbe50,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              (subModel.customerName.length > 0)
                                  ? subModel.customerName.substring(0, 1)
                                  : '',
                              style: TextStyle(
                                  color: AppColors.color_ffffff,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Screen.sp(18)),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    child: _buildCenterWidget(subModel),
                    flex: 1,
                  ),
                  Container(
                    width: 40,
                    child: Icon(
                      !subModel.isSelect
                          ? Icons.radio_button_unchecked
                          : Icons.check_circle,
                      color: !subModel.isSelect
                          ? AppColors.color_cccccc
                          : AppColors.color_maincolor,
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildCenterWidget(CustomerCareListModel subModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              subModel.customerName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.color_212121),
            ),
            Text(
              ' ${subModel.customerMobile}',
              style: TextStyle(fontSize: 14, color: AppColors.color_999999),
            )
          ],
        ),
        Text(subModel.content)
      ],
    );
  }
}
