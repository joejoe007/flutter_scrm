import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/page/main/home/handlecard/handlecard_list_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/viewmodel/memcardlist_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'memshipcard_detail_page.dart';

class MemshipCardSearchPage extends StatefulWidget {
  MemshipCardSearchPage({Key key}) : super(key: key);

  @override
  _MemshipCardSearchPageState createState() {
    return _MemshipCardSearchPageState();
  }
}

class _MemshipCardSearchPageState extends State<MemshipCardSearchPage> {
//  GlobalKey<LoadingContainerState> key = GlobalKey();
  TextEditingController _editingController = TextEditingController();
  MemCardListVModel _memCardListVModel = MemCardListVModel();
  MemCardCustomerBalanceVModel _balanceVModel = MemCardCustomerBalanceVModel();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(title: '余额查询'),
      body: Container(
        color: AppColors.color_f2f2f2,
        child: Column(
          children: <Widget>[
            Container(
                height: 60,
                color: AppColors.color_ffffff,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            NavigatorUtil.getValuePush(
                                    context, HandleCardPage(),
                                    isAnmiate: false)
                                .then((value) {
                              if (value != null) {
                                CustomerInfoModel subModel = value;
                                _memCardListVModel.setCustomerId(subModel.id);
                                _balanceVModel.setCustomerId(subModel.id);
                                _editingController.text = subModel.name;
                              }
                            });
                          },
                        ),
                        AutoMakeSearchBar(
                          hintText: '请输入姓名/手机号/车牌号',
                          isCanWirte: false,
                          editingController: _editingController,
                        ),
                        Positioned(
                          child: Container(
                              color: AppColors.color_transparent,
                              child: GestureDetector(
                                child: Image.asset(AppImages.lightGrayScanImg),
                                onTap: () {
                                  ScanCarNum.scanCarNum().then((value) {
                                    if (value != null) {
                                      _memCardListVModel.setKey(value);
                                      _editingController.text = value;
                                      setState(() {
                                        _memCardListVModel.isNoData = true;

                                        /// 待研究～～～～～～～～～～～
                                      });
                                    }
                                  });
                                },
                              )),
                          right: 10,
                          top: 10,
                          bottom: 10,
                        )
                      ],
                    ))),
            Container(
                height: 40,
                color: AppColors.color_f2f2f2,
                child: ProviderWidget<MemCardCustomerBalanceVModel>(
                    builder: (context, data, child) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              data.showText,
                              style: TextStyle(
                                  color: AppColors.color_909399, fontSize: 13),
                            )),
                      );
                    },
                    model: _balanceVModel)),
            Expanded(
              child: Container(
                child: LoadingContainer<MemCardListVModel>(
                    model: MemCardListVModel(status: '5'),
                    noDateWidget: SafeArea(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 85,
                            height: 65,
                            child: Image.asset(_memCardListVModel.isNoData
                                ? AppImages.nodataMemberImg
                                : AppImages.nodataMemShipListImg),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              _memCardListVModel.isNoData
                                  ? '暂无结果～'
                                  : '选择客户查询余额～',
                              style: TextStyle(
                                  color: AppColors.color_999999, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )),
                    successChild: (data) {
                      _memCardListVModel = data;
                      return SectionTableView(
                        sectionCount: data.list.length,
                        numOfRowInSection: (section) {
                          return data.list[section].length + 1;
                        },
                        cellAtIndexPath: (section, row) {
                          return GestureDetector(
                            onTap: () {
                              NavigatorUtil.push(
                                  context,
                                  new MemShipCardDetailPage(
                                    cardId:
                                        data.list[section][0].cardCustomerId,
                                  ));
                            },
                            child: (row == 0)
                                ? _buildFristRowWidget(data.list[section][row])
                                : _cardlistSubWidget(
                                    data.list[section][row - 1]),
                          );
                        },
                        headerInSection: (section) {
                          return Container(
                            height: (section == 0) ? 0 : 10,
                            color: AppColors.color_f2f2f2,
                          );
                        },
                      );
                    }),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFristRowWidget(MemberCardTypeModel subModel) {
    return Container(
      height: 45,
      color: AppColors.color_f2f2f2,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          color: AppColors.color_ffffff,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  subModel.cardName,
                  style: TextStyle(
                      color: AppColors.color_212121,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardlistSubWidget(MemberCardTypeModel subModel) {
    return Container(
        height: 40,
        color: AppColors.color_f2f2f2,
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              color: AppColors.color_ffffff,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(subModel.itemName),
                    Text(subModel.type == 1
                        ? '${subModel.balance}次'
                        : '${subModel.balance}元')
                  ],
                ),
              ),
            )));
  }
}
