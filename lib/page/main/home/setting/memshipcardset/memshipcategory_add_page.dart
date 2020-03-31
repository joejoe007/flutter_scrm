import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/page/main/home/setting/itemset/itemset_list_page.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/addmemcardprice_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_head_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/moremes_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/memcardcategorydetail_vmodel.dart';
import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/autoalertdialog.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/precision_limit_formatter.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';

class AddMemShipCategoryPage extends StatefulWidget {
  final bool isChange;
  final String cardTypeId;

  AddMemShipCategoryPage({Key key, this.isChange = false, this.cardTypeId})
      : super(key: key);

  @override
  _AddMemShipCategoryPageState createState() {
    return _AddMemShipCategoryPageState();
  }
}

class _AddMemShipCategoryPageState extends State<AddMemShipCategoryPage> {
  List _fristrowList = [
    [true, '名称', '请输入会员卡名称'],
    [true, '售价', '请输入销售价格'],
    [true, '有效期', ''],
    [false, '备注', '请输入备注信息']
  ];

  String _inputPrice = '';
  MemCardCategoryAddVModel _memCardCategoryAddVModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: widget.isChange ? '会员卡详情' : '新增会员卡',
          rightVisible: widget.isChange,
          rightIcon: Icons.more_horiz,
          rightCallback: () {
            if (widget.isChange) {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return Container(
                      child: MoreMesWidget(
                        status: _memCardCategoryAddVModel.addModel.status == 0
                            ? '下架'
                            : '上架',
                        deleteCallback: () {
                          Navigator.pop(context);
                          MyAlertDialog.showAlertDialog(context, '确定删除吗？', () {
                            _memCardCategoryAddVModel.status = '1';
                            _memCardCategoryAddVModel
                                .changeCardTypeStatus((getValue) {
                              Navigator.of(context).pop();
                            });
                          });
                        },
                        changeStatusCallback: () {
                          Navigator.pop(context);
                          MyAlertDialog.showAlertDialog(
                              context,
                              _memCardCategoryAddVModel.addModel.status == 0
                                  ? '确定下架吗？'
                                  : '确定上架吗？', () {
                            _memCardCategoryAddVModel.status =
                                _memCardCategoryAddVModel.addModel.status == 0
                                    ? '2'
                                    : '0';
                            _memCardCategoryAddVModel
                                .changeCardTypeStatus((getValue) {
                              Navigator.of(context).pop();
                            });
                          });
                        },
                      ),
                    );
                  });
            }
          },
        ),
        body: Container(
          color: AppColors.color_f2f2f2,
          child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ProviderWidget<MemCardCategoryAddVModel>(
                    onModelReady: (data) {
                      if (widget.isChange) {
                        data.cardTypeId = widget.cardTypeId;
                        data.getMemCategoryDetail();
                      }
                    },
                    builder: (context, value, child) {
                      _memCardCategoryAddVModel = value;
                      return Container(
                          color: AppColors.color_f2f2f2,
                          child: SafeArea(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: SectionTableView(
                                      sectionCount: 3,
                                      numOfRowInSection: (section) {
                                        return (section == 0)
                                            ? 4
                                            : (section == 1)
                                            ? 1 +
                                            value.moneyList.length +
                                            value.itemlist.length
                                            : 1 +
                                            value.givemoneyList.length +
                                            value.giveitemlist.length;
                                      },
                                      cellAtIndexPath: (section, row) {
                                        if (section == 0) {
                                          return (row == 2)
                                              ? _buildValidity(value)
                                              : MemShipCategoryRowWdiget(
                                            inputFormatters: [row == 1?PrecisionLimitFormatter(2,maxLength: 5):LengthLimitingTextInputFormatter(row ==0?30:100)],
                                            isMust: _fristrowList[row][0],
                                            headStr: _fristrowList[row][1],
                                            hintStr: _fristrowList[row][2],
                                            keyboardType: row == 1
                                                ? ITextInputType.decimal
                                                : ITextInputType.text,
                                            isPrice: (row == 1) ? true : false,
                                            fieldCallBack: (content) {
                                              switch (row) {
                                                case 0:
                                                  value.addModel.name = content;
                                                  break;
                                                case 1:
                                                  value.addModel.price = content;
                                                  break;
                                                case 3:
                                                  value.addModel.remark = content;
                                                  break;
                                                default:
                                                  break;
                                              }
                                            },
                                            textfStr: (row == 0
                                                ? value.addModel.name
                                                : (row == 1)
                                                ? value.addModel.price
                                                .toString()
                                                : (row == 3)
                                                ? value.addModel.remark
                                                .toString()
                                                : ''),
                                          );
                                        } else {
                                          if (row == 0) {
                                            return MemShipCategoryHeaderWidget(
                                              headerStr:
                                              (section == 1) ? '会员卡内容' : '办卡赠送',
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
                                                        keyboardType: ITextInputType.decimal,
                                                        inputFormatters: [PrecisionLimitFormatter(2,maxLength: 5)],
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
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
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
                                                isHaveDelete: true,
                                                tap: (){
                                                  MyAlertDialog.showAlertDialog(context, '确定删除吗？', () {
                                                    value.clearMoneyList();
                                                  });

                                                },
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
                                                isHaveDelete: true,
                                                tap: (){
                                                  MyAlertDialog.showAlertDialog(context, '确定删除吗？', () {
                                                    value.clearGiveMoneyList();
                                                  });

                                                },
                                                content: value.givemoneyList.first.amount
                                                    .toString(),
                                                headStr: '现金',
                                                fieldCallBack: (content) {
                                                  value.addGiveMoneyList(content);
                                                },
                                              );
                                            } else {
                                              return AddMemCardPriceWidget(
                                                  isHaveDelete: true,
                                                  tap: (){

                                                    MyAlertDialog.showAlertDialog(context, '确定删除吗？', () {
                                                      if(section == 1) {
                                                        value.removeItemList(row - 1 - value.moneyList.length);
                                                      }else {
                                                        value.removeGiveItemList(row - 1 - value.givemoneyList.length);
                                                      }
                                                    });

                                                  },
                                                  content: (section == 1)
                                                      ? value.itemlist[row - 1 - value.moneyList.length].amount.toString()
                                                      : value.giveitemlist[row - 1 - value.givemoneyList.length].amount.toString(),
                                                  headStr: (section == 1)
                                                      ? value.itemlist[row - 1 - value.moneyList.length].itemName.toString()
                                                      : value.giveitemlist[row - 1 - value.givemoneyList.length].itemName.toString(),
                                                  fieldCallBack: (content) {
                                                    if (section == 1) {
                                                      value.changeItemList(
                                                          content, row - 1 - value.moneyList.length);
                                                    } else {
                                                      value.changeGiveItemList(
                                                          content, row - 1 - value.givemoneyList.length);
                                                    }
                                                  });
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
                                      height: 80,
                                      child: Center(
                                        child: NormalBtnWidget(
                                          width: 300,
                                          height: 50,
                                          title: '保存',
                                          tap: () {
                                            value.saveCardCategory((result) {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ))
                                ],
                              )));
                    },
                    model: MemCardCategoryAddVModel(limit: false)),
              )),
        )
    );
  }

  Widget _buildValidity(MemCardCategoryAddVModel vModel) {
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
                    Expanded(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  !vModel.limit
                                      ? Icons.radio_button_unchecked
                                      : Icons.check_circle,
                                  color: !vModel.limit
                                      ? AppColors.color_cccccc
                                      : AppColors.color_maincolor,
                                ),
                                onPressed: () {
                                  vModel.setlimit(true);
                                }),
                            Container(
                              width: 40,
                              child: AutoMakeSearchBar(
                                isShowPrefix: false,
                                hintText: '',
                                fristStr: vModel.addModel.validValue == -1
                                    ? '1'
                                    : vModel.addModel.validValue.toString(),
                                blackColor: AppColors.color_transparent,
                                isFromRight: true,
                                keyboardType: ITextInputType.text,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")), //只允许输入小数
                                ],
                                fieldCallBack: (content) {
                                  vModel.setValildValue(content);
                                },
                              ),
                            ),
                            Text(vModel.addModel.validUnit == 1
                                ? '年'
                                : vModel.addModel.validUnit == 2 ? '月' : '日'),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                flex: 1,
              ),
              Container(
                width: 45,
                child: IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      Picker(
                          adapter: PickerDataAdapter<String>(
                              pickerdata: ['年', '月', '日']),
                          changeToFirst: true,
                          hideHeader: false,
                          cancelText: '取消',
                          confirmText: '确定',
                          onConfirm: (Picker picker, List value) {
                            vModel.setUnit(picker.adapter
                                .getSelectedValues()
                                .first
                                .toString());
                          }).showModal(this.context);
                    }),
              )
            ],
          ),
        ));
  }
}
