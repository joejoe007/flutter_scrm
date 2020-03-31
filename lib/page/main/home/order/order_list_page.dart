import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/page/main/home/billing/billing_content_page.dart';
import 'package:flutter_project1/page/main/home/billing/billing_operate_util.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/page/main/home/order/order_detail_page.dart';
import 'package:flutter_project1/page/main/home/order/widget/order_list_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/order_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

class OrderListPager extends StatefulWidget {
  @override
  _OrderListPagerState createState() => _OrderListPagerState();
}

class _OrderListPagerState extends State<OrderListPager> {
  List<String> _headerTitleList = ['开单时间', '结算状态', '订单类型'];
  List<SortCondition> _financeStateList = [];
  List<SortCondition> _orderTypeList = [];
  SortCondition _selectFinanceState;
  SortCondition _selectOrderType;
  GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();

  GlobalKey _stackKey = GlobalKey();
  TextEditingController searchController = TextEditingController();

  OrderVModel _orderVModel;

  @override
  void initState() {
    super.initState();

    _financeStateList.add(SortCondition(name: '全部', id: '', isSelected: true));
    _financeStateList.add(SortCondition(name: '未支付', id: 0, isSelected: false));
    _financeStateList.add(SortCondition(name: '挂帐', id: 1, isSelected: false));
    _financeStateList.add(SortCondition(name: '已结算', id: 4, isSelected: false));
    _selectFinanceState = _financeStateList[0];

    _orderTypeList.add(SortCondition(name: '全部', id: '', isSelected: true));
    _orderTypeList.add(SortCondition(name: '会员卡售卡', id: 2, isSelected: false));
    _orderTypeList.add(SortCondition(name: '项目订单', id: 3, isSelected: false));
    _orderTypeList.add(SortCondition(name: '会员卡充值', id: 4, isSelected: false));
    _orderTypeList.add(SortCondition(name: '会员卡退卡', id: 5, isSelected: false));
    _selectOrderType = _orderTypeList[0];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new MyAppBarView(title: '订单列表'),
        backgroundColor: AppColors.color_f4f4f4,
        body: SafeArea(
            child: Stack(
          key: _stackKey,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: AppColors.color_ffffff,
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Stack(children: <Widget>[
                    AutoMakeSearchBar(
                      fieldCallBack: (content) {
                        if (_orderVModel == null) return;
                        _orderVModel.setKey(content);
                      },
                      hintText: '请输入关键词搜索',
                      editingController: searchController,
                    ),
                    Positioned(child: GestureDetector(child: Image.asset(AppImages.lightGrayScanImg, height: Screen.w(20), width: Screen.w(20),),onTap: (){
                      ScanCarNum.scanCarNum().then((value) {
                        if (value != null) {
                          _orderVModel?.setKey(value);
                          searchController.text = value;
                          setState(() {});
                        }
                      });
                    },), right: Screen.w(18), top: 0, bottom: 0,)
                  ],)
                ),
                // 下拉菜单头部
                GZXDropDownHeader(
                  // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
                  items: [
                    GZXDropDownHeaderItem(_headerTitleList[0]),
                    GZXDropDownHeaderItem(_headerTitleList[1]),
                    GZXDropDownHeaderItem(_headerTitleList[2]),
                  ],
                  // GZXDropDownHeader对应第一父级Stack的key
                  // controller用于控制menu的显示或隐藏
                  controller: _dropdownMenuController,
                  stackKey: _stackKey,

                  // 头部的高度
                  height: Screen.h(40),
                  // 头部背景颜色
                  color: AppColors.color_ffffff,
                  // 文字样式
                  style: TextStyle(
                      color: AppColors.color_666666, fontSize: Screen.sp(14)),
                  // 下拉时文字样式
                  dropDownStyle: TextStyle(
                      color: AppColors.color_ff3c48, fontSize: Screen.sp(14)),
                  // 图标大小
                  iconSize: 20,
                  // 图标颜色
                  iconColor: AppColors.color_666666,
                  // 下拉时图标颜色
                  iconDropDownColor: AppColors.color_ff3c48,
                ),
                Expanded(
                  child: new LoadingContainer<OrderVModel>(
                      onModelReady: (model) {
                        _orderVModel = model;
                      },
                      refreshType: RefreshType.normal,
                      successChild: (model) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            OrderItemModel item = model.list[index];
                            return GestureDetector(
                              child: OrderItemWidget(item),
                              onTap: () {
                                List<operate> operateList = OrderOperate.orderOperateState(item.payStatus,item.status);
                                if(operateList.contains(operate.edit)){
                                  NavigatorUtil.getValuePush(context, BillingContentPage(item.carNo, orderId: item.id,)).then((value){
                                    if(value != null){
                                      model.onDataReady();
                                    }
                                  });
                                } else {
                                  NavigatorUtil.getValuePush(context, OrderDetailPage(item.id, operateList, item.carNo)).then((value){
                                    if(value != null){
                                      model?.onDataReady();
                                    }
                                  });
                                }
                              },
                            );
                          },
                          itemCount: model.list.length,
                        );
                      },
                      model: OrderVModel()), // 待结算,
                ),
              ],
            ),
            // 下拉菜单
            GZXDropDownMenu(
              // controller用于控制menu的显示或隐藏
              controller: _dropdownMenuController,
              // 下拉菜单显示或隐藏动画时长
              animationMilliseconds: 200,
              // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
              menus: [
                GZXDropdownMenuBuilder(
                    dropDownHeight: Screen.h(50) * 3,
                    dropDownWidget:
                    _buildConditionChooseTimeWidget(context, () {
                      _headerTitleList[0] = '开单时间';
                      _orderVModel.setAllTime(startTime: '', endTime: '');
                      _dropdownMenuController.hide();
                    }, (begin) {
                      _headerTitleList[0] = begin + ' ' + StringUtil.checkEmpty(_orderVModel?.endTime?.toString());
                      _orderVModel.setStartTime(begin);
                      _dropdownMenuController.hide();
                    }, (end) {
                      _headerTitleList[0] = StringUtil.checkEmpty(_orderVModel?.startTime?.toString()) + ' ' + end;
                      _dropdownMenuController.hide();
                      _orderVModel.setEndTime(end);
                    })),
                GZXDropdownMenuBuilder(
                    dropDownHeight: Screen.h(50) * _financeStateList.length,
                    dropDownWidget:
                        _buildConditionListWidget(_financeStateList, (value) {
                      _orderVModel.setPayStatus(value.id);
                      _selectFinanceState = value;
                      _headerTitleList[1] = _selectFinanceState.name == '全部'
                          ? '结算状态'
                          : _selectFinanceState.name;
                      _dropdownMenuController.hide();
                      setState(() {});
                    })),
                GZXDropdownMenuBuilder(
                    dropDownHeight: Screen.h(50) * _orderTypeList.length,
                    dropDownWidget:
                        _buildConditionListWidget(_orderTypeList, (value) {
                      _orderVModel.setOrderType(value.id);
                      _selectOrderType = value;
                      _headerTitleList[2] = _selectOrderType.name == '全部'
                          ? '订单类型'
                          : _selectOrderType.name;
                      _dropdownMenuController.hide();
                      setState(() {});
                    })),
              ],
            ),
          ],
        )));
  }

  /// 下拉选择样式
  _buildConditionListWidget(
      items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
            color: AppColors.color_ffffff,
            height: Screen.h(50),
            child: Row(
              children: <Widget>[
                DividerUtil.VDivider(Screen.w(12)),
                Expanded(
                  child: Text(goodsSortCondition.name, style: TextStyle(color: AppColors.color_666666, fontSize: Screen.sp(14)),),
                ),
                goodsSortCondition.isSelected ? Icon(Icons.check, color: AppColors.color_ff3c48, size: Screen.sp(14),) : SizedBox(),
                DividerUtil.VDivider(Screen.w(12)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 下拉时间选择
  _buildConditionChooseTimeWidget(BuildContext context, void all(), void begin(String begin), void end(String end)) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
          color: AppColors.color_ffffff,
          height: Screen.h(50),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      '全部',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.color_666666, fontSize: Screen.sp(14)),
                    )),
              ],
            ),
            onTap: () {
              all();
              setState(() {});
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
          color: AppColors.color_ffffff,
          height: Screen.h(50),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '开始时间',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: AppColors.color_666666, fontSize: Screen.sp(14)),
                )),
                Text(StringUtil.checkEmpty(_orderVModel?.startTime?.toString(), '请选择'),
                    style: TextStyle(
                        color: AppColors.color_666666,
                        fontSize: Screen.sp(14))),
              ],
            ),
            onTap: () {
              CommonWidgetUtil.chooseTime(
                  context, DateTime(1900, 1, 1), DateTime.now(), (time) {
                begin(time);
                setState(() {});
              });
            },
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
            color: AppColors.color_ffffff,
            height: Screen.h(50),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    '结束时间',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppColors.color_666666, fontSize: Screen.sp(14)),
                  )),
                  Text(StringUtil.checkEmpty(_orderVModel?.endTime?.toString(), '请选择'),
                      style: TextStyle(
                          color: AppColors.color_666666,
                          fontSize: Screen.sp(14))),
                ],
              ),
              onTap: () {
                CommonWidgetUtil.chooseTime(
                    context, DateTime(1900, 1, 1), DateTime.now(), (time) {
                  end(time);
                  setState(() {});
                });
              },
            )),
      ],
    );
  }
}

class SortCondition {
  String name;
  dynamic id;
  bool isSelected;

  SortCondition({this.name, this.id, this.isSelected});
}
