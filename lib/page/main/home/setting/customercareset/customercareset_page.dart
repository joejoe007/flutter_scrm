import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customercareset_model.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/viewmodel/customercareset_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class CustomerCareSetPage extends StatefulWidget {
  CustomerCareSetPage({Key key}) : super(key: key);

  @override
  _CustomerCareSetPageState createState() {
    return _CustomerCareSetPageState();
  }
}

class _CustomerCareSetPageState extends State<CustomerCareSetPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '客户关怀设置',
      ),
      body: Container(
        color: AppColors.color_f4f4f4,
        child: SafeArea(
          child: LoadingContainer<CustomerCareSetVModel>(
              successChild: (data) {
                if (data.list.length > 0) {
                  CustomerCareSetModel setModel = data.list[0];
                  data.isOpen = setModel.autoSwitch == 1 ? true : false;
                }
                return SectionTableView(
                  sectionCount: 1,
                  numOfRowInSection: (section) {
                    return data.list.length;
                  },
                  cellAtIndexPath: (section, row) {
                    return _buildListWidget(data, data.list[row]);
                  },
                  headerInSection: (section) {
                    return Container(
                        height: 45,
                        color: AppColors.color_f4f4f4,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: FlatButton.icon(
                              color: AppColors.color_transparent,
                              splashColor: AppColors.color_transparent,
                              icon: Icon(
                                !data.isOpen
                                    ? Icons.radio_button_unchecked
                                    : Icons.check_circle,
                                color: !data.isOpen
                                    ? AppColors.color_cccccc
                                    : AppColors.color_maincolor,
                              ),
                              onPressed: () {
                                data.setIsOpen(data.isOpen ? false : true);
                              },
                              label: Text(
                                '开启自动提醒 （短信/微信）',
                                style: TextStyle(
                                    color: AppColors.color_666666,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ));
                  },
                );
              },
              model: CustomerCareSetVModel()),
        ),
      ),
    );
  }

  Widget _buildListWidget(
      CustomerCareSetVModel vModel, CustomerCareSetModel subModel) {
    return Container(
      height: 90,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.color_ffffff,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          subModel.typeName,
                          style: TextStyle(
                              color: AppColors.color_212121,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Switch(
                              value: subModel.alarmSwitch == 1,
                              activeColor: AppColors.color_f73b42,
                              activeTrackColor: AppColors.color_dbdbdb,
                              onChanged: (bool val) {
                                vModel.setSwitch(val, subModel);
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                text: '在会员卡到期前',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.color_666666),
                                children: [
                              TextSpan(
                                  text: '3天',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.color_f73b42)),
                              TextSpan(
                                  text: '进行提醒',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.color_666666)),
                            ])),
                        Container(
                            child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) {
                                  return Container(
                                    child: _buildDialog(subModel,(value){
                                      subModel.arguments = value;
                                      vModel.changeArgument(subModel);
                                    }),
                                  );
                                  ;
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '修改',
                                style: TextStyle(color: AppColors.color_999999),
                              ),
                              Icon(Icons.chevron_right,
                                  color: AppColors.color_999999),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildDialog(CustomerCareSetModel setModel, GetBackValue getBackValue) {
    String changeNumStr = '';
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: 312,
            height: 200,
            decoration: BoxDecoration(
                color: AppColors.color_ffffff,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: <Widget>[
                Container(
                  height: 75,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(
                          setModel.typeName,
                          style: TextStyle(
                              color: AppColors.color_333333,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Positioned(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close)),
                        right: 10,
                        height: 40,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.color_f4f4f4,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.5))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: AutoMakeSearchBar(
                                blackColor: AppColors.color_f4f4f4,
                                hintText: '请输入${setModel.typeName}提醒时间',
                                hintColor: AppColors.color_dbdbdb,
                                fontSize: 15,
                                isShowPrefix: false,
                                fieldCallBack: (content) {
                                  changeNumStr = content;
                                },
                              ),
                              flex: 1,
                            ),
                            Container(
                              width: 40,
                              child: Text('天',style: TextStyle(color: AppColors.color_666666, fontSize: 15),),
                            )
                          ],
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                      child: Center(
                    child: NormalBtnWidget(
                      title: '确定',
                      width: 288,
                      height: 45,
                      tap: () {
                        Navigator.pop(context);
                        getBackValue(changeNumStr);
                      },
                    ),
                  )),
                  flex: 1,
                )
              ],
            ),
          ),
        ));
  }
}
