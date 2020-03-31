import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

import 'mine/electricitywebview_page.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPageState();
  }
}

class MyPageState extends State<MyPage> {
  List _imgList = [
    [
      AppImages.mineWaitPay,
      AppImages.mineWaitSend,
      AppImages.mineGetGoods,
      AppImages.mineMes,
      AppImages.mineSale
    ],
    [
      AppImages.mineWallet,
      AppImages.mineTicket,
      AppImages.mineOpenTicket,
      AppImages.mineRedInviate,
      AppImages.mineOwnerShip,
      AppImages.mineAddress,
      AppImages.mineSetting,
    ],
    [
      AppImages.mineMap,
      AppImages.mineTotal,
      AppImages.mineCommission,
      AppImages.mineWaitdo,
      AppImages.mineApproval
    ]
  ];

  List _titleList = [
    [
      '待付款',
      '待发货',
      '待收获',
      '评价',
      '退货/售后',
    ],
    [
      '我的钱包',
      '我的卡券',
      '开具发票',
      '注册邀请',
      '业务归属',
      '地址管理',
      '设置',
    ],
    [
      '考勤打卡',
      '日结统计',
      '提成统计',
      '待办事项',
      '审批',
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        // android 更改状态栏颜色
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.color_f84432,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.color_f84432,
        ),
        child: Scaffold(
            backgroundColor: AppColors.color_f3f3f3,
            appBar: PreferredSize(
              //ios下更改状态栏颜色
              //判断是是否是android，是android需去掉AppBar，否则无AnnotatedRegion无效
              child: Theme.of(context).platform == TargetPlatform.android
                  ? Container()
                  : AppBar(
                      backgroundColor: AppColors.color_f84432, elevation: 0),
              preferredSize: Size.fromHeight(0),
            ),
            body: SafeArea(child: _buildListWidget())));
  }

  Widget _buildListWidget() {
    return SectionTableView(
      sectionCount: 4,
      numOfRowInSection: (section) {
        return (section == 0) ? 1 : 2;
      },
      cellAtIndexPath: (section, row) {
        if (section == 0) {
          return _buildHeaderWidget(section);
        } else if (section == 3 && row > 0) {
          return _buildBottomWidget();
        } else {
          return (row == 0)
              ? _buildHeadTitle(section)
              : _buildRowCollectionWidget(section);
        }
      },
      headerInSection: (section) {
        return Container(
          height: (section == 0) ? 0 : 10,
          color: AppColors.color_f4f4f4,
        );
      },
      divider: Container(
        color: AppColors.color_f4f4f4,
        height: 1,
      ),
    );
  }

  Widget _buildHeaderWidget(int section) {
    return Container(
        height: 255,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                color: AppColors.color_f84432,
                child: Center(
                  child: _buildHeaderInfoWidget(),
                ),
              ),
              left: 0,
              right: 0,
              top: 0,
              height: 120,
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.color_ffffff,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: _buildMyOrderWidget(section),
              ),
              left: 0,
              right: 0,
              top: 110,
              bottom: 0,
            ),
          ],
        ));
  }

  Widget _buildHeaderInfoWidget() {
    return Container(
      height: 70,
      color: AppColors.color_transparent,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.color_ffffff,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '仙女王炸',
                      style: TextStyle(color: AppColors.color_ffffff),
                    ),
                    Text(
                      '556565666|江苏省苏州市',
                      style: TextStyle(color: AppColors.color_ffffff),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Container(
              width: 45,
              child: Icon(
                Icons.chevron_right,
                color: AppColors.color_ffffff,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyOrderWidget(int section) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '我的订单',
                    style: TextStyle(
                        color: AppColors.color_434343,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Text('查看全部订单'),
                      Icon(Icons.chevron_right),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.color_f3f3f3,
          ),
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: _buildStatusWidget(section, 0),
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildStatusWidget(section, 1),
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildStatusWidget(section, 2),
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildStatusWidget(section, 3),
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildStatusWidget(section, 4),
                    flex: 1,
                  ),
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _buildStatusWidget(int section, int tag) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, ElectricityWebViewPage());
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              child: Image.asset(_imgList[section][tag]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(_titleList[section][tag]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadTitle(int section) {
    return Container(
      color: AppColors.color_ffffff,
      height: 50,
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              section == 0 ? '我的服务' : (section == 1) ? 'SCRM' : '专属秘籍',
              style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget _buildRowCollectionWidget(int section) {
    return Container(
      color: AppColors.color_ffffff,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: _imgList[section].length,
          physics: new NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: _buildStatusWidget(section, index));
          }),
    );
  }

  Widget _buildBottomWidget() {
    return Container(
      height: 90,
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildBottomSubWidget(0),
          ),
          Container(
            color: AppColors.color_f3f3f3,
            width: 1,
            height: 30,
          ),
          Expanded(
            child: _buildBottomSubWidget(1),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSubWidget(int tag) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Align(
                    alignment: Alignment.centerLeft,
                    child: tag == 0
                        ? Text(
                      '我的收藏',
                      style: TextStyle(
                          color: AppColors.color_ff6d2f, fontSize: 14),
                    )
                        : Text(
                      '我的缓存',
                      style: TextStyle(
                          color: AppColors.color_9a4bc7, fontSize: 14),
                    ),
                  ),flex: 1,),

                  Expanded(child:  Align(
                    alignment: Alignment.topLeft,
                    child: Text(tag == 0 ? '可随时查看喜欢的收藏':'缓存可反复查看',style: TextStyle(
                        color: AppColors.color_aeaeae, fontSize: 12),),
                  ),flex: 1,),

                ],
              ),
            ),
            flex: 1,
          ),
          Container(
            width: 60,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                width: 40,
                height: 40,
                child: Image.asset(tag == 0
                    ? AppImages.mineColletion
                    : AppImages.mineDownLoad),
              ),
            ),
          )
        ],
      ),
    );
  }
}
