import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/page/main/home/billing/billing_page.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/page/main/home/finance/business_sum_page.dart';
import 'package:flutter_project1/page/main/home/home/home_search_page.dart';
import 'package:flutter_project1/page/main/home/order/order_list_page.dart';
import 'package:flutter_project1/util/log_util.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/home_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/flutter_marquee/flutter_marquee.dart';
import 'package:flutter_project1/widget/loading_container.dart';

import 'package:flutter_project1/page/main/home/handlecard/widget/column_image_text_grid_view.dart';
import 'package:quiver/strings.dart';
import 'home/account/account_receive_page.dart';
import 'home/customer/customer_search_page.dart';

import 'home/customercare/customercarelist_page.dart';
import 'home/handlecard/opencardlist_page.dart';
import 'home/membershipcard/membershipcard_search_page.dart';
import 'home/setting/shopsetting_page.dart';
import 'home/store/store_outlaay_page.dart';

class WorkBenchPage extends StatefulWidget {
  @override
  WorkBenchPageState createState() => new WorkBenchPageState();
}

class WorkBenchPageState extends State<WorkBenchPage> {

  var controller = MarqueeController();
  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: AppColors.color_f4f4f4,
        body: LoadingContainer<HomeVModel>(
            onModelReady: (model) {
              model.setSuccess();
            },
            successChild: (model) {
              return Container(
                child: ListView(
                  children: <Widget>[
                    /// 顶部
                    _topModel(model),

                    /// 中间模块
                    _functionModel(model),

                    /// 客户关怀
                    _clientCareModel(model),

                    SizedBox(
                      height: Screen.h(50),
                    ),
                  ],
                ),
              );
            },
            model: HomeVModel()));
  }

  /// 顶部
  Widget _topModel(HomeVModel model) {
    return Stack(
      children: <Widget>[
        Container(
          height: Screen.h(190),
          decoration: BoxDecoration(
              borderRadius:
                  new BorderRadius.vertical(bottom: Radius.circular(25)),
              color: AppColors.color_f73b42),
        ),
        Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      child: Container(
                        child: AutoMakeSearchBar(
                          isCanWirte: false,
                          hintText: '查订单、查客户',
                        ),
                      ),
                      onTap: () {
                        NavigatorUtil.push(context, HomeSearchPage());
                      },
                      behavior: HitTestBehavior.opaque,
                    )),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: Screen.w(12)),
                        child: Image.asset(
                          AppImages.homeScanCarNum,
                          fit: BoxFit.cover,
                          width: Screen.w(20),
                          height: Screen.w(20),
                        ),
                      ),
                      onTap: () {
                        ScanCarNum.scanCarNum().then((value) {
                          if(isEmpty(value)){
                            return;
                          }
                          Log.info('carNum' + value.toString());
                          NavigatorUtil.push(
                              context,
                              HomeSearchPage(
                                key: value,
                              ));
                        });
                      },
                    )
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.fromLTRB(0, Screen.h(30), 0, Screen.h(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              model.sumMoneyShow ?
                              isEmpty(model.homeStatisticsModel?.todayCar?.toString()) ?
                                  '0' : model.homeStatisticsModel.todayCar.toString()
                                  : '***',
                              style: CStyle.style(AppColors.color_ffffff, 21),
                            ),
                            Text(
                              '进店台次(台)',
                              style: CStyle.style(AppColors.color_ffffff, 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: Screen.h(30),
                        child: VerticalDivider(
                          width: Screen.w(1),
                          color: AppColors.color_ffffff,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              model.sumMoneyShow ?
                              isEmpty(model.homeStatisticsModel?.todayTotal?.toString()) ? '0' : model.homeStatisticsModel?.todayTotal?.toString()
                                  : '***',
                              textAlign: TextAlign.center,
                              style:
                              CStyle.style(AppColors.color_ffffff, 21),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '营业额(元)',
                                  textAlign: TextAlign.center,
                                  style: CStyle.style(AppColors.color_ffffff, 12),
                                ),
                                DividerUtil.VDivider(Screen.w(10)),
                                GestureDetector(
                                  child: model.sumMoneyShow
                                      ? Icon(
                                    Icons.visibility,
                                    color: AppColors.color_ffffff,
                                    size: Screen.w(19),
                                  )
                                      : Icon(
                                    Icons.visibility_off,
                                    color: AppColors.color_ffffff,
                                    size: Screen.w(19),
                                  ),
                                  onTap: () {
                                    model.sumMoneyShow = !model.sumMoneyShow;
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Screen.h(30),
                        child: VerticalDivider(
                          width: Screen.w(1),
                          color: AppColors.color_ffffff,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              model.sumMoneyShow ?
                              isEmpty(model.homeStatisticsModel?.todayCardConsume?.toString()) ? '0' : model.homeStatisticsModel?.todayCardConsume?.toString()
                                  : '***',
                              style: CStyle.style(AppColors.color_ffffff, 21),
                            ),
                            Text(
                              '实收(元)',
                              style: CStyle.style(AppColors.color_ffffff, 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: Screen.h(57),
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  AppImages.iconHomeBilling,
                                  fit: BoxFit.cover,
                                  width: Screen.w(20),
                                  height: Screen.w(20),
                                ),
                                DividerUtil.VDivider(Screen.w(13)),
                                Text(
                                  '开单',
                                  style:
                                      CStyle.style(AppColors.color_333333, 17),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          /// 开单
                          NavigatorUtil.push(context, BillingPage());
                        },
                      )),
                      Expanded(
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              /// 办卡
                              NavigatorUtil.push(
                                  context, new OpenCardListPage());
                            },
                            child: Container(
                              height: Screen.h(57),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      AppImages.iconHomeOpenCard,
                                      fit: BoxFit.cover,
                                      width: Screen.w(20),
                                      height: Screen.w(20),
                                    ),
                                    DividerUtil.VDivider(Screen.w(13)),
                                    Text('办卡',
                                        style: CStyle.style(
                                            AppColors.color_333333, 17)),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  /// 功能模块
  Widget _functionModel(HomeVModel model) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.color_ffffff,
        borderRadius: new BorderRadius.all(new Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ColumnImgTextGridView(
            noOrderCount: int.parse(StringUtil.checkEmpty(model.homeStatisticsModel?.notPaidOrderCount?.toString(), '0').toString()),
            crossAxisCount: 4,
            data: ['订单', '余额查询', '客户', '门店支出', '挂帐应收', '营业汇总', '门店设置', '客户关怀'],
            itemClick: (item, index) {
              switch (index) {
                case 0:

                  /// 订单
                  NavigatorUtil.push(context, OrderListPager());
                  break;
                case 1:

                  /// 余额查询
                  NavigatorUtil.push(context, new MemshipCardSearchPage());
                  break;
                case 2:

                  ///客户
                  NavigatorUtil.push(context, new CustomerListSearchPage());
                  break;
                case 3:

                  /// 门店支出
                  NavigatorUtil.push(context, new StoreOutlayPage());
                  break;
                case 4:

                  /// 挂帐应收
                  NavigatorUtil.push(context, new AccountReceivePage());

                  break;
                case 5:

                  /// 营业汇总
                  NavigatorUtil.push(context, new BusinessSumPage());
                  break;
                case 6:

                  /// 营业设置
                  NavigatorUtil.push(context, new ShopSettingPage());
                  break;
                case 7:

                  /// 客户关怀
                  NavigatorUtil.push(context, new CustomerCareListPage());
                  break;

                default:
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  /// 客户关怀
  Widget _clientCareModel(HomeVModel model) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.all(Screen.w(12)),
          margin: EdgeInsets.only(top: Screen.h(8)),
          decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: new BorderRadius.all(new Radius.circular(5)),
          ),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppImages.homeCare,
                fit: BoxFit.cover,
                width: Screen.w(47),
                height: Screen.h(51),
              ),
              new Expanded(
                  child: Container(
                    height: Screen.h(50),
                    margin: EdgeInsets.only(left: Screen.w(12)),
                    alignment: Alignment.centerLeft,
                    child: Marquee(
                      key: key,
                      textList: model.showConsumerWidget(), // List<Text>, textList and textSpanList can only have one of code.
                      fontSize: Screen.sp(14), // text size
                      scrollDuration: Duration(seconds: 1), // every scroll duration
                      stopDuration: Duration(seconds: 3), //every stop duration
                      tapToNext: false, // tap to next
                      textColor: AppColors.color_333333, // text color
                      controller: controller, // the controller can get the position
                    ),
                  )),
              new Icon(
                Icons.chevron_right,
                color: AppColors.color_afafaf,
              ),
            ],
          ),
        ),
        onTap: () {
          /// 客户关怀
          NavigatorUtil.push(context, new CustomerCareListPage());
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
