import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';

import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'home/customer/customer_search_page.dart';
import 'home/setting/employeerightsset/employeerights_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List _imgList = [
    AppImages.HomeMarketing,
    AppImages.HomeSearch,
    AppImages.HomeCancelCenter,
    AppImages.HomeRole,
    AppImages.HomeMem,
    AppImages.HomeMemInfo,
    AppImages.HomeInventory,
    AppImages.HomeMaketingData
  ];

  List _titleList = [
    '营销工具',
    '质保查询',
    '核销中心',
    '员工管理',
    '客户管理',
    '会员信息',
    '库存盘点',
    '经营数据'
  ];
  
  List _bannerList = [
    AppImages.HomeFristBanner,
    AppImages.HomeSecondBanner,
    AppImages.HomeThridBanner,
    AppImages.HomeForthBanner
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBarView(
          title: '首页',
          leftVisible: false,
        ),
        body: Container(
            child: SectionTableView(
              sectionCount: 3,
              numOfRowInSection: (section) {
                return (section == 0) ? 1 : (section == 1) ? 3 : 4;
              },
              cellAtIndexPath: (section, row) {
                if (section == 0) {
                  return _buildFristRowWidget();
                } else if (section == 1) {
                  if (row == 0) {
                    return _buildHeadTitle(section);
                  } else {
                    return _buildListWidget();
                  }
                } else {
                  if (row == 0) {
                    return _buildHeadTitle(section);
                  } else {
                    return _buildSecondListWidget();
                  }
                }
              },
              headerInSection: (section) {
                return Container(
                  height: section == 2 ? 10 : 0,
                  color: AppColors.color_f3f3f3,
                );
              },
//          divider: Container(
//            color: AppColors.color_f3f3f3,
//            height: 1,
//          ),
            )));
  }

  Widget _buildFristRowWidget() {
    return Container(
      color: AppColors.color_ffffff,
      child: Column(
        children: <Widget>[_buildBannerWidget(), _buildRowCollectionWidget()],
      ),
    );
  }

  Widget _buildBannerWidget() {
    return Container(
      width: Screen.w(),
      height: 150,
      color: AppColors.color_ffffff,
      child: Swiper(
        itemBuilder: (context, index) =>
            Image.asset(_bannerList[index],fit: BoxFit.cover,),
        itemCount: 3,
        loop: true,
        autoplay: true,
//        control:  SwiperControl(),
        scrollDirection: Axis.horizontal,
        pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
        duration: 300,
        viewportFraction: 0.88,
        scale: 0.9,
        onTap: (index) => {},
      ),
    );
  }

  Widget _buildRowCollectionWidget() {
    return Container(
      color: AppColors.color_ffffff,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: _imgList.length,
          physics: new NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  switch (index){
                    case 0: /// 营销工具
                      break;
                    case 1: /// 质保查询
                      break;
                    case 2: /// 核销中心
                      break;
                    case 3: /// 员工管理
                      NavigatorUtil.push(context, new EmployrightsListPage());
                      break;
                    case 4: /// 客户管理
                      NavigatorUtil.push(context, new CustomerListSearchPage());
                      break;
                    case 5: /// 会员信息
                      break;
                    case 6: /// 库存盘点
                      break;
                    case 7: /// 经营数据
                      break;
                  }
                },
                child: _buildStatusWidget(index));
          }),
    );
  }

  Widget _buildStatusWidget(int index) {
    return Container(
      color: AppColors.color_ffffff,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: Image.asset(_imgList[index]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              _titleList[index],
              style: TextStyle(color: AppColors.color_434343, fontSize: 14),
            ),
          ),
        ],
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
              section == 1 ? '营销指导' : section == 2 ? '热门活动' : '操作攻略',
              style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget _buildListWidget() {
    return Container(
        color: AppColors.color_ffffff,
//        height: 250,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              Container(
                height: 160,
                width: double.infinity,
                child: Image.network(
                  'http://g.hiphotos.baidu.com/zhidao/pic/item/c83d70cf3bc79f3d6e7bf85db8a1cd11738b29c0.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '纽曼GPS定位跟踪器系列迷你系列',
                    style: TextStyle(
                        color: AppColors.color_434343,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text('黑精灵ab+车立靓漆面修复套装修复套装施工黑精灵ab+车立靓漆面修复套装修复套装施工',
                      style: TextStyle(
                          color: AppColors.color_999999, fontSize: 12)),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.remove_red_eye,color: AppColors.color_999999,),
                        Text(' 9999',
                            style: TextStyle(
                                color: AppColors.color_999999, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.message,color: AppColors.color_999999),
                            Text(' 9999',
                                style: TextStyle(
                                    color: AppColors.color_999999,
                                    fontSize: 12)),
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildSecondListWidget() {
    return Container(
        color: AppColors.color_ffffff,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  'http://g.hiphotos.baidu.com/zhidao/pic/item/c83d70cf3bc79f3d6e7bf85db8a1cd11738b29c0.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10), child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '纽曼GPS定位跟踪器系列迷你系列',
                            style: TextStyle(
                                color: AppColors.color_434343,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text('黑精灵ab+车立靓漆面修复套装修复套装施工黑精灵ab+车立靓漆面修复套装修复套装施工',
                              style: TextStyle(
                                  color: AppColors.color_999999, fontSize: 12)),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.remove_red_eye,color: AppColors.color_999999),
                                Text(' 9999',
                                    style: TextStyle(
                                        color: AppColors.color_999999,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.message,color: AppColors.color_999999),
                                    Text(' 9999',
                                        style: TextStyle(
                                            color: AppColors.color_999999,
                                            fontSize: 12)),
                                  ],
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),),
                flex: 1,
              ),
            ],
          ),
        ));
  }
}
