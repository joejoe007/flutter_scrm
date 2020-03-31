import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/memberinfo_list_widget.dart';
import 'package:flutter_project1/page/main/home/openorder/widget/choose_waytobuy_widget.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class OpenOrderDetailPage extends StatefulWidget {
  OpenOrderDetailPage({Key key}) : super(key: key);

  @override
  _OpenOrderDetailPageState createState() {
    return _OpenOrderDetailPageState();
  }
}

class _OpenOrderDetailPageState extends State<OpenOrderDetailPage> {
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
        appBar: MyAppBarView(title: '开单'),
        body: SafeArea(
          child: Container(
              color: AppColors.color_f2f2f2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _buildListView(),
                    flex: 1,
                  ),
                  _buildBottomView()
                ],
              )),
        ));
  }

  Widget _buildBottomView() {
    return Container(
      height: 55,
      color: AppColors.color_e1e2e3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '应收 ¥3',
                style: TextStyle(fontSize: 18),
              ),
            ),
            flex: 1,
          ),
          Container(
            width: 60,
            child: MyAutoBtn(
              isHaveBorder: true,
              title: '预付',
              circle: 20,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              width: 60,
              child: MyAutoBtn(
                  isHaveBorder: true,
                  title: '挂帐',
                  circle: 20,
                  onPressed: () {}),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: 100,
              child: MyAutoBtn(
                  title: '完成收款',
                  backColor: AppColors.color_999999,
                  textColor: AppColors.color_ffffff,
                  circle: 20,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (BuildContext context) {
                          return ChooseWayToBuyWidget();
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SectionTableView(
      sectionCount: 5,
      numOfRowInSection: (section) {
        return (section == 2 || section == 3) ? 3 : 1;
      },
      cellAtIndexPath: (section, row) {
        if (section == 0) {
          return _buildHeadWidget();
        } else if (section == 1) {
          return MemInfoList(CustomerInfoModel());
        } else if (section == 4) {
          return _buildPriceWidget();
        } else {
          if (row == 0) {
            return _buildHeadTitleWidget();
          } else {
            return _buildListWidget();
          }
        }
      },
      sectionHeaderHeight: (section) => 10,
      headerInSection: (section) {
        return Container(height: 10.0, color: AppColors.color_f2f2f2);
      },
      divider: Container(
        color: AppColors.color_f2f2f2,
        height: 1,
      ),
    );
  }

  Widget _buildHeadWidget() {
    return Container(
      height: 35,
      color: AppColors.color_999999,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '单号：10967888',
              style: TextStyle(color: AppColors.color_ffffff),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              '单号：待支付',
              style: TextStyle(color: AppColors.color_ffffff),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeadTitleWidget() {
    return Container(
      height: 45,
      width: Screen.w(),
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          '订单信息',
          style: TextStyle(
              color: AppColors.color_333333,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildListWidget() {
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('会员卡'),
            ),
          ),
          Expanded(
            child: Container(
              child: Text('无可用优惠券'),
            ),
            flex: 1,
          ),
          Container(
            width: 45,
            child: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }

  Widget _buildPriceWidget() {
    return Container(
      height: 100,
      width: Screen.w(),
      color: AppColors.color_ffffff,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('应收金额'),
          Text(
            '¥1999999',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
