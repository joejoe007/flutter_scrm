import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/page/main/home/handlecard/opencardresult_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/home/setting/itemset/itemset_list_page.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/addmemcardprice_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_head_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/memcarddetail_vmodel.dart';
import 'package:flutter_project1/widget/autoalertdialog.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class MemShipCardContinuePage extends StatefulWidget {
  String cardId;

  MemShipCardContinuePage({Key key, this.cardId}) : super(key: key);

  @override
  _MemShipCardContinuePageState createState() {
    return _MemShipCardContinuePageState();
  }
}

class _MemShipCardContinuePageState extends State<MemShipCardContinuePage> {
  List _fristrowList = [
    [true, '名称', '请输入会员卡名称'],
    [true, '有效期', ''],
    [false, '续卡备注', '请输入备注信息']
  ];

  String _inputPrice = '';
  MemCardContinueVModel _memCardContinueVModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '续卡详情',
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ProviderWidget<MemCardContinueVModel>(
              builder: (context, value, child) {
                _memCardContinueVModel = value;
                value.cardId = widget.cardId;
                return Container(
                    color: AppColors.color_f2f2f2,
                    child: SafeArea(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SectionTableView(
                            sectionCount: 4,
                            numOfRowInSection: (section) {
                              return (section == 0)
                                  ? _fristrowList.length
                                  : (section == 1)
                                      ? 1 +
                                          value.moneyList.length +
                                          value.itemlist.length
                                      : (section == 2)
                                          ? 1 +
                                              value.givemoneyList.length +
                                              value.giveitemlist.length
                                          : 3;
                            },
                            cellAtIndexPath: (section, row) {
                              if (section == 0) {
                                return (row == 1)
                                    ? _buildValidity(value)
                                    : MemShipCategoryRowWdiget(
                                        isMust: _fristrowList[row][0],
                                        headStr: _fristrowList[row][1],
                                        hintStr: _fristrowList[row][2],
                                        fieldCallBack: (content) {},
                                      );
                              } else {
                                if (row == 0) {
                                  return MemShipCategoryHeaderWidget(
                                    hideAfterBtn: (section == 3) ? true : false,
                                    headerStr: (section == 1)
                                        ? '续卡内容'
                                        : (section == 2) ? '续卡赠送' : '结算信息',
                                    isMust: (section == 1),
                                    leftBtnCallBack: () {
                                      /// 添加现金
                                      AutoAlertDialog.showAlertDialog(
                                        context,
                                        Container(
                                          child: Card(
                                            elevation: 0,
                                            child: AutoMakeSearchBar(
                                              blackColor:
                                                  AppColors.color_transparent,
                                              isShowPrefix: false,
                                              fieldCallBack: (content) {
                                                _inputPrice = content;
                                              },
                                            ),
                                          ),
                                        ),
                                        () {
                                          if (section == 1) {
                                            value.addMoneyList(_inputPrice);
                                          } else {
                                            value.addGiveMoneyList(_inputPrice);
                                          }
                                        },
                                        '现金',
                                      );
                                    },
                                    rightBtnCallBack: () {
                                      /// 添加项目
                                      NavigatorUtil.getValuePush(
                                          context,
                                          ItemSetListPage(
                                            isfromChoose: true,
                                          )).then((data) {
                                        ItemListModel subMode = data;
                                        if (section == 1) {
                                          value.addItemlist(subMode);
                                        } else {
                                          value.addGiveItemlist(subMode);
                                        }
                                      });
                                    },
                                  );
                                } else {
                                  if (value.moneyList.length > 0 &&
                                      row == 1 &&
                                      section == 1) {
                                    return AddMemCardPriceWidget(
                                      content: value.moneyList.first.amount
                                          .toString(),
                                      headStr: '现金',
                                      fieldCallBack: (content) {
                                        value.addMoneyList(content);
                                      },
                                    );
                                  } else if (value.givemoneyList.length > 0 &&
                                      row == 1 &&
                                      section == 2) {
                                    return AddMemCardPriceWidget(
                                      content: value.givemoneyList.first.amount
                                          .toString(),
                                      headStr: '现金',
                                      fieldCallBack: (content) {
                                        value.addGiveMoneyList(content);
                                      },
                                    );
                                  } else {
                                    if (section == 3) {
                                      return MemShipCategoryRowWdiget(
                                        headStr: row == 1 ? '续卡合计' : '优惠',
                                        isCanWirte: row == 1 ? false : true,
                                        keyboardType: ITextInputType.decimal,
                                        isPrice: true,
                                        hintStr: row == 1 ? '' : '请输入优惠金额',
                                        textfStr: (row == 1)
                                            ? value.totalPrice.toString()
                                            : value.discount,
                                        fieldCallBack: (content) {
                                          if (row == 2) {
                                            /// 优惠金额
                                            value.setDiscount(content);
                                          }
                                        },
                                      );
                                    } else {
                                      return AddMemCardPriceWidget(
                                          content: (section == 1)
                                              ? value
                                                  .itemlist[row -
                                                      1 -
                                                      value.moneyList.length]
                                                  .amount
                                                  .toString()
                                              : value
                                                  .giveitemlist[row -
                                                      1 -
                                                      value
                                                          .givemoneyList.length]
                                                  .amount
                                                  .toString(),
                                          headStr: (section == 1)
                                              ? value
                                                  .itemlist[row -
                                                      1 -
                                                      value.moneyList.length]
                                                  .itemName
                                                  .toString()
                                              : value
                                                  .giveitemlist[row -
                                                      1 -
                                                      value
                                                          .givemoneyList.length]
                                                  .itemName
                                                  .toString(),
                                          fieldCallBack: (content) {
                                            if (section == 1) {
                                              value.changeItemList(
                                                  content,
                                                  row -
                                                      1 -
                                                      value.moneyList.length);
                                            } else {
                                              value.changeGiveItemList(
                                                  content,
                                                  row -
                                                      1 -
                                                      value.givemoneyList
                                                          .length);
                                            }
                                          });
                                    }
                                  }
                                }
                              }
                            },
                            sectionHeaderHeight: (section) => 10,
                            headerInSection: (section) {
                              return Container(
                                  height: 10.0, color: AppColors.color_f2f2f2);
                            },
                            divider: Container(
                              color: AppColors.color_f2f2f2,
                              height: 1,
                            ),
                          ),
                          flex: 1,
                        ),
                        Container(
                          color: AppColors.color_ffffff,
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RichText(
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
                                          text: value.lastPrice.toString(),
                                          style: TextStyle(
                                              fontSize: Screen.sp(20),
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.color_f73b42)),
                                    ])),
                                NormalBtnWidget(
                                  height: 40,
                                  width: 120,
                                  title: '收款',
                                  tap: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            AppColors.color_transparent,
                                        context: context,
                                        builder: (BuildContext dialogContex) {
                                          return PayWayWidget(
                                            getBackValue: ((payType) {
                                              value.payType =
                                                  payType.toString();
                                              value.submmitData((value) {
                                                NavigatorUtil.push(
                                                    context,
                                                    OpenCardResultPage(
                                                        resultType: ResultType.getMoney
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
                    )));
              },
              model: MemCardContinueVModel()),
        ));
  }

  Widget _buildValidity(MemCardContinueVModel vModel) {
    return Container(
        color: AppColors.color_ffffff,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 85,
                  child: RichText(
                      text: TextSpan(
                          text: '有效期',
                          style: TextStyle(
                              color: AppColors.color_212121,
                              fontSize: Screen.sp(15)),
                          children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        )
                      ]))),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        vModel.setlimit(false);
                      },
                      icon: Icon(
                        vModel.limit
                            ? Icons.radio_button_unchecked
                            : Icons.check_circle,
                        color: vModel.limit
                            ? AppColors.color_cccccc
                            : AppColors.color_maincolor,
                      ),
                      label: Text(
                        '不限',
                        style: TextStyle(color: AppColors.color_666666),
                      ),
                      splashColor: AppColors.color_transparent,
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        vModel.setlimit(true);
                      },
                      icon: Icon(
                        !vModel.limit
                            ? Icons.radio_button_unchecked
                            : Icons.check_circle,
                        color: !vModel.limit
                            ? AppColors.color_cccccc
                            : AppColors.color_maincolor,
                      ),
                      label: Text(
                        vModel.expireDate,
                        style: TextStyle(color: AppColors.color_666666),
                      ),
                      splashColor: AppColors.color_transparent,
                    ),
                  ],
                ),
                flex: 1,
              ),
              Container(
                width: 40,
                child: IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      DatePicker.showDatePicker(context, locale: LocaleType.zh,
                          onConfirm: (DateTime time) {
                        vModel.setSelectDate(time);
                      });
                    }),
              )
            ],
          ),
        ));
  }
}
