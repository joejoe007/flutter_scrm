import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/page/main/home/customer/customer_search_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/employeelist_widget.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/memcardcategorydetail_vmodel.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/precision_limit_formatter.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

import 'opencardresult_page.dart';

class OpenCardStepPage extends StatefulWidget {
  final String cardTypeId;
  dynamic userId;

  OpenCardStepPage({Key key, this.cardTypeId, this.userId}) : super(key: key);

  @override
  _OpenCardStepPageState createState() {
    return _OpenCardStepPageState();
  }
}

class _OpenCardStepPageState extends State<OpenCardStepPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '开卡',
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: AppColors.color_f4f4f4,
            child: SafeArea(
                child: ProviderWidget<MemCardCategoryDetailVModel>(
                    onModelReady: (t) {
                      if(widget.userId != null){
                        t.getUserInfo(widget.userId);
                      }
                      t.cardTypeId = widget.cardTypeId;
                      t.onDataReady();
                    },
                    builder: (context, data, child) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: SectionTableView(
                                sectionCount: 4,
                                numOfRowInSection: (section) {
                                  if (section == 0) {
                                    return 1;
                                  } else if (section == 1) {
                                    return data.infoModel.id != null ? 3 : 0;
                                  } else if (section == 2) {
                                    return data.cardList.length;
                                  } else {
                                    return 3;
                                  }
                                },
                                cellAtIndexPath: (section, row) {
                                  if (section == 0) {
                                    return _buildFristSectionWidget(
                                        data.categoryAddModel);
                                  } else if (section == 3 && row > 0) {
                                    return _buildChooseWidget(row, data);
                                  } else {
                                    return Container(
                                      height: 45,
                                      child: MemShipCategoryRowWdiget(
                                        isCanWirte:
                                            (section == 2) ? false : true,
                                        isMust: (section == 2 || section == 3)
                                            ? false
                                            : true,
                                        headStr: section == 2
                                            ? data.cardList[row].itemName
                                            : section == 1
                                                ? (row == 0
                                                    ? '姓名'
                                                    : (row == 1)
                                                        ? '手机号'
                                                        : '车牌号')
                                                : '优惠',
                                        hintStr: (section == 3 && row == 0)
                                            ? '请输入优惠金额'
                                            : '请输入',
                                        inputFormatters: [PrecisionLimitFormatter(2)],
                                        isPrice: section == 2,
                                        keyboardType: section == 3
                                            ? ITextInputType.decimal
                                            : (section == 1 && row == 1)
                                                ? ITextInputType.phone
                                                : ITextInputType.text,
                                        unit: (section == 2)
                                            ? (data.cardList[row].type == 5
                                                ? '元'
                                                : '次')
                                            : '',
                                        fieldCallBack: (content) {
                                          if (section == 3) {
                                            data.setLasePirce(content);
                                          } else if (section == 1) {
                                            if (row == 0) {
                                              data.infoModel.name = content;
                                            } else if (row == 1) {
                                              data.infoModel.mobile = content;
                                            } else {
                                              data.infoModel.carNos = content;
                                            }
                                          }
                                        },
                                        textfStr: section == 2
                                            ? (data.cardList[row].type == 5
                                                ? data.cardList[row].amount
                                                    .toString()
                                                : data.cardList[row].amount
                                                    .toString())
                                            : section == 1
                                                ? (row == 0
                                                    ? data.infoModel.name
                                                    : (row == 1)
                                                        ? data.infoModel.mobile
                                            : data.infoModel.carNos)
                                                : section == 3
                                                    ? data.discount
                                                    : '',
                                      ),
                                    );
                                  }
                                },
                                headerInSection: (section) {
                                  if (section == 1) {
                                    return widget.userId == null ? Container(
                                        height: 50,
                                        color: AppColors.color_ffffff,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: GestureDetector(
                                            child: Container(
                                              child: AutoMakeSearchBar(
                                                isCanWirte: false,
                                                hintText: '搜索客户姓名/手机号/车牌号',
                                              ),
                                            ),
                                            onTap: () {
                                              NavigatorUtil.getValuePush(
                                                  context,
                                                  CustomerListSearchPage(
                                                    isChoose: true,
                                                  )).then((value) {
                                                data.setInfoModel(value);
                                              });
                                            },
                                            behavior: HitTestBehavior.opaque,
                                          ),
                                        )) : SizedBox(height: 0,);
                                  } else if (section == 2 || section == 3) {
                                    return Container(
                                      height: 45,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              (section == 2) ? '会员卡信息' : '结算信息',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          )),
                                    );
                                  } else {
                                    return Container(
                                      color: AppColors.color_f4f4f4,
                                      height: 1,
                                    );
                                  }
                                },
                                divider: Container(
                                  color: AppColors.color_f4f4f4,
                                  height: 1,
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Container(
                            color: AppColors.color_ffffff,
                            height: Screen.h(60),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: RichText(
                                      text: TextSpan(
                                          text: '应收：',
                                          style: TextStyle(
                                              fontSize: Screen.sp(15),
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.color_212121),
                                          children: [
                                            TextSpan(
                                                text: '¥',
                                                style: TextStyle(
                                                    fontSize: Screen.sp(15),
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.color_f73b42)),
                                            TextSpan(
                                                text: data.lastPrice.toString(),
                                                style: TextStyle(
                                                    fontSize: Screen.sp(20),
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.color_f73b42)),
                                          ])),flex: 1,),

                                  NormalBtnWidget(
                                    height: Screen.h(40),
                                    width: Screen.w(120),
                                    title: '收款',
                                    tap: () {
                                      showModalBottomSheet(
                                          backgroundColor:
                                              AppColors.color_transparent,
                                          context: context,
                                          builder: (BuildContext dialogContex) {
                                            return PayWayWidget(
                                              getBackValue: ((payType) {
                                                data.payType =
                                                    payType.toString();
                                                data.createMemCard((getValue) {
                                                  NavigatorUtil.push(
                                                      context,
                                                      OpenCardResultPage(
                                                        resultType:
                                                            ResultType.openCard,
                                                      ));
                                                });
                                              }),
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    model: MemCardCategoryDetailVModel())),
          ),
        ));
  }

  Widget _buildFristSectionWidget(MemCardCategoryAddModel subModel) {
    return (subModel.id == null)
        ? Text('')
        : Container(
            height: 80,
            color: AppColors.color_ffffff,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        subModel.name,
                        style: TextStyle(
                            color: AppColors.color_212121,
                            fontSize: Screen.sp(16),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '有效期：${subModel.validValue == -1 ? '不限' : subModel.validValue.toString() + subModel.validUnit.toString()}',
                        style: TextStyle(
                            color: AppColors.color_333333,
                            fontSize: Screen.sp(12)),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.color_e9cd97, AppColors.color_d7b174]),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          );
  }

  Widget _buildChooseWidget(int row, MemCardCategoryDetailVModel vModel) {
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Container(
                width: 85,
                child: (row == 1)
                    ? RichText(
                        text: TextSpan(
                            text: '生效日期',
                            style: TextStyle(
                                color: AppColors.color_212121,
                                fontSize: Screen.sp(15)),
                            children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ]))
                    : Text(
                        '销售人员',
                        style: TextStyle(
                            color: AppColors.color_212121,
                            fontSize: Screen.sp(15)),
                      )),
            Expanded(
              child: Container(
                  child: GestureDetector(
                onTap: () {
                  if (row == 1) {
                    ///日期
                    DatePicker.showDatePicker(context, locale: LocaleType.zh,
                        onConfirm: (DateTime time) {
                      vModel.setSelectDate(time);
                    });
                  } else {
                    showModalBottomSheet(
                        backgroundColor: AppColors.color_transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return EmployeeListWidget(
                            selectModel: vModel.selectStoreuserModel,
                            getBackValue: (value) {
                              /// 获取选择的员工
                              StoreUserListModel submodel = value;
                              vModel.setSelectSaleMem(submodel);
                            },
                          );
                        });
                  }
                },
                child: Text(
                  (row == 1 && vModel.beginDate.length > 0)
                      ? vModel.beginDate
                      : (row == 2 && vModel.saleName.length > 0)
                          ? vModel.saleName
                          : '请选择',
                  style: TextStyle(
                      color: AppColors.color_666666, fontSize: Screen.sp(14)),
                  textAlign: TextAlign.right,
                ),
              )),
              flex: 1,
            ),
            Container(
              width: 35,
              child: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }
}
