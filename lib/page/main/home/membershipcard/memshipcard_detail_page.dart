import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/memcarddetail_model.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/page/main/home/membershipcard/renewmemcard_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/memcarddetail_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

import 'memshipcardcontinue_page.dart';

class MemShipCardDetailPage extends StatefulWidget {
  String cardId;

  MemShipCardDetailPage({Key key, this.cardId}) : super(key: key);

  @override
  _MemShipCardDetailPageState createState() {
    return _MemShipCardDetailPageState();
  }
}

class _MemShipCardDetailPageState extends State<MemShipCardDetailPage> {
  String _currentCardId = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '会员卡详情',
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: _buildLoadWidget(),
              flex: 1,
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      height: 40,
                      width: 135,
                      child: MyAutoBtn(
                        title: '退卡',
                        textFontSize: Screen.sp(17),
                        backColor: AppColors.color_ffffff,
                        textColor: AppColors.color_f73b42,
                        borderColor: AppColors.color_f73b42,
                        isHaveBorder: true,
                        circle: 20,
                        onPressed: () {
                          NavigatorUtil.push(
                              context,
                              RenewMemCardPage(
                                cardId: _currentCardId.toString(),
                              ));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: NormalBtnWidget(
                      title: '续卡',
                      height: 40,
                      width: 205,
                      tap: () {
                        NavigatorUtil.push(
                            context,
                            MemShipCardContinuePage(
                              cardId: _currentCardId.toString(),
                            ));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }

  Widget _buildLoadWidget() {
    return LoadingContainer<MemCardDetailVModel>(
      successChild: (data) {
        _currentCardId = data.cardDetailModel.id;
        return Container(
            color: AppColors.color_f2f2f2,
            child: SectionTableView(
              sectionCount: 4,
              numOfRowInSection: (section) {
                return section == 0
                    ? 1
                    : (section == 1)
                        ? 1 + data.cardDetailModel.contents.length
                        : (section == 2)
                            ? data.cardDetailModel.gifts.length
                            : 1 + data.list.length;
              },
              cellAtIndexPath: (section, row) {
                if (section == 0) {
                  return _buildHeadWidget(data.cardDetailModel);
                } else if ((section == 1 && row == 0) ||
                    (section == 3 && row == 0)) {
                  return _fristRowWidget(section);
                } else {
                  if ((section == 1 && row > 0) || section == 2) {
                    return _secondSectionListWidget(section,
                        (section == 2) ? row : row - 1, data.cardDetailModel);
                  } else {
                    return _buildListWidget(data.list[row - 1]);
                  }
                }
              },
              headerInSection: (section) {
                return Container(
                    height: (section == 2) ? 0.01 : 10.0,
                    color: AppColors.color_f2f2f2);
              },
              sectionHeaderHeight: (section) => 10,
              divider: Container(
                color: AppColors.color_f2f2f2,
                height: 1,
              ),
            ));
      },
      model: MemCardDetailVModel(cardId: widget.cardId),
    );
  }

  Widget _buildHeadWidget(MemCardDetailModel subModel) {
    return Container(
      height: 180,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.color_ffffff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [AppColors.color_e9cd97, AppColors.color_d7b174]),
                ),
                height: 40,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(subModel.cardName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Container(
                            width: 55,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: AppColors.color_212121, width: 0.5),
                            ),
                            child: Center(
                              child: Text(
                                (subModel.status == 0)
                                    ? '正常'
                                    : (subModel.status == 2) ? '退卡' : '作废',
                              ),
                            )
                          ))
                    ],
                  ),
                ),
              ),

              Container(
                height: 0.5,
                color: AppColors.color_f4f4f4,
              ),
              Expanded(
                child: _secondSectionListWidget(0, 0, subModel),
                flex: 1,
              ),
              Expanded(
                child: _secondSectionListWidget(0, 1, subModel),
                flex: 1,
              ),
              Expanded(
                child: _secondSectionListWidget(0, 2, subModel),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fristRowWidget(int section) {
    return Container(
        height: 45,
        color: AppColors.color_ffffff,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              section == 1 ? '卡内剩余' : '扣卡记录',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget _secondSectionListWidget(
      int section, int row, MemCardDetailModel listModel) {
    String beforeStr = '';
    String afterStr = '';
    if (section == 0) {
      beforeStr = (row == 0) ? '卡号' : (row == 1) ? '持卡人' : '有效期至';
      afterStr = (row == 0)
          ? listModel.cardNo
          : (row == 1) ? listModel.customerName : listModel.expireTime;
    } else if (section == 2) {
      beforeStr = listModel.gifts[row].itemName + ('（赠送）');
      afterStr = (listModel.gifts[row].type == 1)
          ? '${listModel.gifts[row].balance.toString()}次'
          : '¥${listModel.gifts[row].balance.toString()}';
    } else {
      /// section 1
      /// 1项目 5现金
      beforeStr = listModel.contents[row].itemName;
      afterStr = (listModel.contents[row].type == 1)
          ? '${listModel.contents[row].balance.toString()}次'
          : '¥${listModel.contents[row].balance.toString()}';
    }
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: (section == 0 && row == 2)
            ? BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))
            : BorderRadius.all(Radius.circular(1)),
        gradient: LinearGradient(
            colors: (section == 0)
                ? [AppColors.color_e9cd97, AppColors.color_d7b174]
                : [AppColors.color_ffffff, AppColors.color_ffffff]),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(beforeStr), Text(afterStr)],
        ),
      ),
    );
  }

  Widget _buildListWidget(MemCardConsumeRecordsModel subModel) {
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              width: 120,
              child: Text(subModel.orderNo),
            ),
          ),
          Expanded(
            child: Text(
              subModel.payType == 5
                  ? '现金抵扣¥${subModel.amount}'
                  : '${subModel.itemName}消费${subModel.amount}次',
              textAlign: TextAlign.right,
            ),
            flex: 1,
          ),
          Container(
            width: 45,
            child: Icon(
              Icons.chevron_right,
              color: AppColors.color_999999,
            ),
          )
        ],
      ),
    );
  }
}
