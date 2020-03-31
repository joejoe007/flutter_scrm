import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/memcarddetail_model.dart';
import 'package:flutter_project1/page/main/home/handlecard/opencardresult_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/home/openorder/widget/choose_waytobuy_widget.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/viewmodel/memcarddetail_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/precision_limit_formatter.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class RenewMemCardPage extends StatefulWidget {
  String cardId;

  RenewMemCardPage({Key key, this.cardId}) : super(key: key);

  @override
  _RenewMemCardPageState createState() {
    return _RenewMemCardPageState();
  }
}

class _RenewMemCardPageState extends State<RenewMemCardPage> {
  MemCardDetailVModel _memCardDetailVModel = MemCardDetailVModel();
  TextEditingController _editingController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '会员卡退卡',
        ),
        body: Container(
          color: AppColors.color_f4f4f4,
          child: SafeArea(
              child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: LoadingContainer<MemCardDetailVModel>(
                    successChild: (data) {
                      _memCardDetailVModel = data;
                      return _buildListWidget(data.cardDetailModel);
                    },
                    model: MemCardDetailVModel(cardId: widget.cardId),
                  ),
                  flex: 1,
                ),
                Container(
                    height: 80,
                    child: Center(
                      child: NormalBtnWidget(
                        width: 300,
                        height: 50,
                        title: '确认退卡',
                        tap: () {
                          _memCardDetailVModel.submmitData((getValue) {
                            /// 退卡成功
                            NavigatorUtil.push(
                                context,
                                OpenCardResultPage(
                                    resultType: ResultType.backCar));
                          });
                        },
                      ),
                    ))
              ],
            ),
          )),
        ));
  }

  Widget _buildListWidget(MemCardDetailModel detailModel) {
    return SectionTableView(
      sectionCount: 3,
      numOfRowInSection: (section) {
        return (section == 0)
            ? 1
            : (section == 1) ? detailModel.contents.length + 1 : 4;
      },
      cellAtIndexPath: (section, row) {
        if (section == 0 || (section == 1 && row > 0)) {
          return _onlyreadListWidget(section, row, detailModel);
        } else if (section == 2 && row > 0) {
          return _editWidget(row ,detailModel);
        } else {
          return _headerWidget(section, detailModel);
        }
      },
      headerInSection: (section) {
        return Container(height: 10, color: AppColors.color_f4f4f4);
      },
      sectionHeaderHeight: (section) => 10,
      divider: Container(
        color: AppColors.color_f4f4f4,
        height: 1,
      ),
    );
  }

  Widget _headerWidget(int section, MemCardDetailModel subModel) {
    return Container(
        height: 45,
        color: AppColors.color_ffffff,
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  section == 1 ? '卡内剩余' : '退款信息',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Visibility(
                  child: Text(
                    '不含赠送',
                    style: TextStyle(color: AppColors.color_f73b42),
                  ),
                  visible: section == 1 ? true : false,
                )
              ],
            )));
  }

  Widget _onlyreadListWidget(
      int section, int row, MemCardDetailModel subModel) {
    String contentBefore = '';
    String contentAfter = '';
    if (section > 0) {
      contentBefore = subModel.contents[row - 1].itemName;
      contentAfter = (subModel.contents[row - 1].type == 1)
          ? '${subModel.contents[row - 1].balance.toString()}次'
          : '¥${subModel.contents[row - 1].balance.toString()}';
    }

    Container container = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 120,
            child: Text(
              '售价',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(subModel.salePrice.toString() + '元'),
          )
        ],
      ),
    );

    Container secondContainer = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            contentBefore,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            contentAfter,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );

    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: (section == 0) ? container : secondContainer,
      ),
    );
  }

  Widget _editWidget(int row, MemCardDetailModel detailModel) {
    AutoMakeSearchBar searchBar = AutoMakeSearchBar(
      isShowPrefix: false,
      isFromRight: true,
      blackColor: AppColors.color_ffffff,
      fristStr: row == 1
          ? _memCardDetailVModel.refundPrice
          :  _memCardDetailVModel.remark,
      fieldCallBack: (content) {
        if (row == 1) {
          if(double.parse(content)>double.parse(detailModel.salePrice)) { /// 退卡金额不可大于售价
            MyToast.showToast('退还金额不可大于售卡金额');
            _memCardDetailVModel.clearCurrentInputPrice();
          }else {
            _memCardDetailVModel.refundPrice = content;
          }
        } else if (row == 3) {
          _memCardDetailVModel.remark = content;
        }
      },
      inputFormatters: [(row == 1)?PrecisionLimitFormatter(2):LengthLimitingTextInputFormatter(100)],
      hintText: row == 1 ? '请输入退还金额' : '请输入退卡备注',
      keyboardType: row == 1 ? ITextInputType.decimal : ITextInputType.text,
      fontSize: 14,
    );

    Stack stack = Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return PayWayWidget(
                    getBackValue: (value) {
                      // 微信3 支付宝4 现金2 银联5
                      _editingController.text = value == 3
                          ? '微信'
                          : value == 4 ? '支付宝' : value == 2 ? '现金' : '银联';
                      _memCardDetailVModel.payType = value;
                    },
                  );
                });
          },
        ),
        AutoMakeSearchBar(
          isShowPrefix: false,
          isFromRight: true,
          blackColor: AppColors.color_ffffff,
          hintText: '请选择',
          fontSize: 14,
          isCanWirte: false,
          editingController: _editingController,
        )
      ],
    );
    return Container(
        height: 45,
        color: AppColors.color_ffffff,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Container(
                  width: 120,
                  child: (row > 2)
                      ? Text('退卡备注')
                      : _richText((row == 1) ? '退还金额' : '退还方式')),
              Expanded(
                child: (row == 2) ? stack : searchBar,
                flex: 1,
              ),
              Visibility(
                child: Container(
                  width: 40,
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.color_999999,
                  ),
                ),
                visible: row == 2 ? true : false,
              )
            ],
          ),
        ));
  }

  Widget _richText(String text) {
    return RichText(
        text: TextSpan(
            text: text,
            style: TextStyle(color: AppColors.color_333333),
            children: <TextSpan>[
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red),
          )
        ]));
  }
}
