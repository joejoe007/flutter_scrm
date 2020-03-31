import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/model/project_list_item_model.dart';
import 'package:flutter_project1/page/main/home/billing/member_balance_page.dart';
import 'package:flutter_project1/page/main/home/billing/member_coupon_page.dart';
import 'package:flutter_project1/page/main/home/billing/project_list_page.dart';
import 'package:flutter_project1/page/main/home/billing/recommend_billing_page.dart';
import 'package:flutter_project1/page/main/home/billing/widget/employee_list_mu_choose_widget.dart';
import 'package:flutter_project1/page/main/home/customer/customer_add_person_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/precision_limit_formatter.dart';
import 'package:flutter_project1/widget/round_check_box.dart';
import 'package:quiver/strings.dart';

import 'billing_operate_util.dart';
import 'member_card_deduction_page.dart';

class BillingContentPage extends StatefulWidget {
  List<operate> operateList; /// 操作权限
  String carNum;/// 车牌号开单
  dynamic orderId;/// 订单id

  BillingContentPage(this.carNum, {this.orderId});

  @override
  BillingContentState createState() => new BillingContentState();
}

class BillingContentState extends State<BillingContentPage> {
  bool billing = true;

  BillingContentVModel _billingContentVModel;
  bool sheetVisibility = false;

  @override
  void initState() {
    super.initState();
    billing = isNotEmpty(widget.carNum) && widget.orderId == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: billing
          ? MyAppBarView(
              title: '开单',
            )
          : MyAppBarView(
              title: '开单',
              rightIcon: Icons.more_horiz,
              rightCallback: () async {
                await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(Screen.w(), Screen.h(80), 0, 0),
                    items: <PopupMenuItem<String>>[
                      new PopupMenuItem<String>(
                          height: Screen.h(40),
                          value: '撤单',
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: new Text('撤单', style: CStyle.style(AppColors.color_212121, 14),),
                            onTap: () {
                              CommonWidgetUtil.showCustomDialogWidget(context,
                                  centerChild: Text('确认撤单吗?', style: CStyle.style(AppColors.color_999999, 16),), sure: () {
                                _billingContentVModel.cancelOrder(context, widget.orderId);
                              });
                            },
                          )),
                    ]);
              },
            ),
      body: SafeArea(
          child: LoadingContainer<BillingContentVModel>(
              onModelReady: (model) {
                _billingContentVModel = model;
                if (billing) {
                  model.getUserInfo(widget.carNum);
                } else {
                  model.getUserInfo(widget.carNum);// 根据车牌拿用户信息
                  model.getOrderCommonInfo(widget.orderId);// 订单基础数据
                  model.getOrderItemList(widget.orderId);// 订单内容单项数据
                  model.getSettlementInfo(widget.orderId);// 订单结算数据
                }
                model.setSuccess();
              },
              successChild: (model) {
                return Container(
                    color: AppColors.color_f4f4f4,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                /// 中间部分
                                Container(
                                    height: double.maxFinite,
                                    child: ListView(
                                      children: <Widget>[
                                        /// 顶部个人信息
                                        oldCustomer(context, model),

                                        /// 订单内容信息
                                        model.hasChooseProjectList.length == 0 ? _noProject(context, model) : _hasProject(context, model),
                                      ],
                                    )),
                                Visibility(
                                  child: Positioned(
                                    child: _showHasChoose(context, model),
                                  ),
                                  visible: sheetVisibility,
                                )
                              ],
                            ),
                            height: double.maxFinite,
                          ),
                        ),

                        /// 底部信息
                        Divider(
                          height: Screen.h(0.5),
                        ),
                        Container(
                            color: AppColors.color_ffffff,
                            height: Screen.h(50),
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                            child: Container(width: Screen.w(), child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Text('应收：¥' + model.finalGetMoney().toString(), style: CStyle.style(AppColors.color_212121, 14),),
                                      Visibility(child: Icon(Icons.keyboard_arrow_up, color: AppColors.color_999999,), visible: model.finalGetMoney() > 0,)
                                    ],
                                  ),
                                  onTap: () {
                                    if(model.finalGetMoney() > 0){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Future.delayed(Duration(milliseconds: 500), (){
                                        setState(() {
                                          sheetVisibility = !sheetVisibility;
                                        });
                                      });
                                    }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            AutoMakeLayoutWidget(
                                              width: Screen.w(75),
                                              height: Screen.h(30),
                                              bgCircle: 17,
                                              borderColor: AppColors.color_ff3b25,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('更多', style: CStyle.style(AppColors.color_ff3b25, 14),),
                                                  Icon(Icons.keyboard_arrow_up, color: AppColors.color_ff3b25,)
                                                ],
                                              ),
                                              gestureTapCallback: () async {
                                                await showMenu(
                                                    context: context,
                                                    position: RelativeRect.fromLTRB(Screen.w(100), Screen.h(500), Screen.w(100), 0),
                                                    items: <PopupMenuItem<String>>[
                                                      new PopupMenuItem<String>(
                                                        value: '挂帐',
                                                        child: GestureDetector(
                                                          child: new Text('挂帐', style: CStyle.style(AppColors.color_212121, 14),),
                                                          onTap: () {
                                                            if (model.hasChooseProjectList.length == 0) {
                                                              MyToast.showToast('未选择订单项');
                                                              return;
                                                            }
                                                            CommonWidgetUtil.showCustomDialogWidget(context, centerChild: Text('确认挂帐吗?', style: CStyle.style(AppColors.color_999999, 16),), sure: () {
                                                              /// 挂帐
                                                              model.submitBilling(context, orderId: widget.orderId, settlement: true, book: true);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      new PopupMenuItem<String>(value: '预收',
                                                          child: GestureDetector(
                                                            child: new Text('预收', style: CStyle.style(AppColors.color_212121, 14),), onTap: () {
                                                            if (model.hasChooseProjectList.length == 0) {
                                                              MyToast.showToast('未选择订单项');
                                                              return;
                                                            }
                                                            if (model.preMoney != 0) {
                                                              MyToast.showToast('已经是预收单');
                                                              return;
                                                            }
                                                            CommonWidgetUtil.showCustomDialogWidget(context, height: Screen.h(230), title: '预收', managerWidgetSelf: false, centerChild: StatefulBuilder(
                                                              builder: (context, state) {return preWidget(model, state);},), sure: () {
                                                              if (model.preMoney == 0.0) {
                                                                MyToast.showToast('请输入预收金额');
                                                                return;
                                                              }
                                                              if (model.payWay == -1) {
                                                                MyToast.showToast('请选择支付方式');
                                                                return;
                                                              }
                                                              model.submitBilling(context, orderId: widget.orderId, repay: true);
                                                              Navigator.of(context).pop();
                                                            });
                                                          },
                                                          )),
                                                    ]);
                                              },
                                            ),
                                            AutoMakeLayoutWidget(
                                              width: Screen.w(75),
                                              height: Screen.h(30),
                                              gestureTapCallback: () {
                                                if (model.hasChooseProjectList.length == 0) {
                                                  MyToast.showToast('未选择订单项');
                                                  return;
                                                }
                                                CommonWidgetUtil.showCustomDialogWidget(context, centerChild: Text('确认保存吗？', style: CStyle.style(AppColors.color_999999, 16),), sure: () {
                                                  /// 保存
                                                  model.submitBilling(context, orderId: widget.orderId, save: true,);
                                                });
                                              },
                                              bgCircle: 17,
                                              borderColor: AppColors.color_ff3b25,
                                              child: Text('保存', style: CStyle.style(AppColors.color_ff3b25, 14),),
                                            ),
                                            AutoMakeLayoutWidget(
                                              width: Screen.w(75),
                                              height: Screen.h(30),
                                              gestureTapCallback: () {
                                                if (model.hasChooseProjectList.length == 0) {
                                                  MyToast.showToast('未选择订单项');
                                                  return;
                                                }
                                                showModalBottomSheet(backgroundColor: AppColors.color_transparent, context: context,
                                                    builder: (BuildContext dialogContex) {
                                                      return PayWayWidget(
                                                        getBackValue: ((payType) async {
                                                          print('支付方式' + payType.toString());
                                                          await model.setPayType(payType);
                                                          /// 收款
                                                          model.submitBilling(context, orderId: widget.orderId, settlement: true);
                                                        }),
                                                      );
                                                    });
                                              }, bgCircle: 17, gradient: LinearGradient(colors: [AppColors.color_fb5f65, AppColors.color_f73b42]),
                                              child: Text('收款', style: CStyle.style(AppColors.color_ffffff, 14),),
                                            ),
                                          ],
                                        ),
                                      ),),))
                              ],
                            ),),)
                      ],
                    ));
              },
              model: BillingContentVModel())),
    );
  }

  /// 顶部用户信息
  Widget oldCustomer(BuildContext context, BillingContentVModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.color_ffffff, borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: EdgeInsets.fromLTRB(Screen.w(0), Screen.w(12), 0, Screen.w(12)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(Screen.w(12)),
              child: Row(
                children: <Widget>[
                  Container(
                      height: Screen.w(45),
                      width: Screen.w(45),
                      child: CircleAvatar(
                          child: Text(StringUtil.checkEmpty(model.customerInfoModel?.name?.toString(), '未').substring(0, 1),
                            style: TextStyle(fontSize: Screen.sp(20), color: AppColors.color_ffffff, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: AppColors.color_fbbe50)),
                  DividerUtil.VDivider(Screen.w(16)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(widget.carNum, style: TextStyle(fontSize: Screen.sp(16), color: AppColors.color_212121, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,
                            ),
                            DividerUtil.VDivider(Screen.w(8.5)),
                            Visibility(
                              child: AutoMakeLayoutWidget(
                                width: Screen.w(30),
                                height: Screen.h(18),
                                bgCircle: 5,
                                gradient: LinearGradient(colors: [AppColors.color_f2c97f, AppColors.color_cb993e]),
                                child: Text('会员', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(12)),
                                ),
                              ),
                              visible: Member.boolMember(model.customerInfoModel?.customerType),
                            ),
                            Visibility(
                              child: AutoMakeLayoutWidget(
                                width: Screen.w(30),
                                height: Screen.h(18),
                                bgCircle: 5,
                                bgColor: AppColors.color_909399,
                                child: Text('新车', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(12)),
                                ),
                              ),
                              visible: model.customerInfoModel == null,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        Visibility(
                          child: Align(
                            child: Text(StringUtil.checkEmpty(model.customerInfoModel?.name?.toString()) + ' ' + StringUtil.checkEmpty(model.customerInfoModel?.mobile?.toString()),
                              style: TextStyle(fontSize: Screen.sp(14), color: AppColors.color_666666),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          visible: model.customerInfoModel != null,
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                  Center(child: Icon(Icons.chevron_right, color: AppColors.color_999999,),
                  ),
                ],
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              /// 完善用户信息
              NavigatorUtil.getValuePush(context, CustomerAddPersonPage(carNum: widget.carNum, consumerId: model?.customerInfoModel?.id, keyCard: model.keyCard, orderId: widget.orderId,)).then((value){
                if(value != null){
                  model.keyCard = value;
                  model.getUserInfo(widget.carNum);
                }
              });
            },
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          Visibility(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.all(Screen.w(12)),
                child: Row(
                  children: <Widget>[
                    Text('推荐开单', style: CStyle.style(AppColors.color_666666, 14),),
                    Expanded(
                      child: Text('余额 ¥' + StringUtil.checkEmpty(model.balanceMode?.balance?.toString(), '0') + ' 剩余扣次' + StringUtil.checkEmpty(model.balanceMode?.leftTimes?.toString(), '0'),
                        textAlign: TextAlign.right,
                        style: CStyle.style(AppColors.color_999999, 14),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                NavigatorUtil.getValuePush(context, RecommendBillingPage(model.customerInfoModel.id)).then((value) {
                  if (value == null) return;
                  switch (value[0]) {
                    case 0:
                    /// 会员卡
                      model.setRecommendChooseCard(value[1]);
                      break;
                    case 1:
                    /// 消费记录
                      model.setRecommendRecord(value[1]);
                      break;
                  }
                });
              },
            ),
            visible: model.customerInfoModel != null && model.preMoney == 0,
          ),
        ],
      ),
    );
  }

  /// 新增项目按钮界面
  Widget _noProject(BuildContext context, BillingContentVModel model) {
    return Center(
      child: AutoMakeLayoutWidget(
        margin: EdgeInsets.only(top: Screen.h(100)),
        gradient: LinearGradient(colors: [AppColors.color_fb5f65, AppColors.color_f73b42]),
        gestureTapCallback: () {
          NavigatorUtil.getValuePush(context, ProjectListPage(consumerId: model.customerInfoModel?.id,)).then((value) {
            if (value == null) return;
            model.setProjectList = value;
          });
        },
        child: Text('选择项目', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(17)),
        ),
        height: Screen.h(50),
        width: Screen.w(300),
        bgCircle: 25,
      ),
    );
  }

  /// 显示应收明细的
  Widget _showHasChoose(BuildContext context, BillingContentVModel model) {
    return Container(
      color: Color(0xb3212121),
      child: Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  sheetVisibility = !sheetVisibility;
                });
              },
            ),
            height: Screen.h(300),
          ),
          Container(decoration: BoxDecoration(color: AppColors.color_ffffff, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            height: Screen.h(50),
            child: Stack(
              children: <Widget>[
                Center(child: Text('应收明细', style: TextStyle(fontSize: Screen.sp(17), fontWeight: FontWeight.bold),)),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sheetVisibility = !sheetVisibility;
                      });
                    },
                    child: Icon(Icons.close),
                  ),
                  right: Screen.w(12),
                  top: Screen.h(15),
                ),
              ],
            ),
          ),
          Divider(
            height: Screen.h(0.5),
            color: AppColors.color_999999,
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return allListDetail()[index];
                },
                itemCount: allListDetail().length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: Screen.h(0.5),
                  );
                },
              ),
              color: AppColors.color_ffffff,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> allListDetail(){
    List<Widget> list = [];
    if(_billingContentVModel.getAllContentMoney() != 0){
      list.add(_itemTextWidget('订单合计', '¥' + _billingContentVModel.getAllContentMoney().toString()));
    }
    if(_billingContentVModel.getChooseCardMoney() != 0){
      list.add(_itemTextWidget('扣次', '¥' + _billingContentVModel.getChooseCardMoney().toString()));
    }
    if(_billingContentVModel.getLeftMoney() != 0){
      list.add(_itemTextWidget('余额抵扣', '¥' + _billingContentVModel.getLeftMoney().toString()));
    }
    if(_billingContentVModel.handDiscount != 0){
      list.add(_itemTextWidget('优惠', '¥' + _billingContentVModel.handDiscount.toString()));
    }
    if(_billingContentVModel.preMoney != 0){
      list.add(_itemTextWidget('预收', '¥' + _billingContentVModel.preMoney.toString()));
    }
    return list;
  }

  /// 显示信息的框子
  Widget _itemTextWidget(String title, String text,
      {EdgeInsetsGeometry margin}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
      height: Screen.h(45),
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121, fontSize: Screen.sp(15)),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                color: AppColors.color_999999, fontSize: Screen.sp(14)),
          ),
        ],
      ),
    );
  }

  /// 有项目订单项目结算信息
  Widget _hasProject(BuildContext context, BillingContentVModel model, ) {
    return Container(
      child: Column(
        children: <Widget>[
          /// 订单内容
          orderContent(context, billing || model.preMoney == 0 ,model),
          DividerUtil.HDivider(Screen.h(8)),
          /// 结算信息
          Container(
            color: AppColors.color_ffffff,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Text('结算信息', style: CStyle.style(AppColors.color_434343, 17),),
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                ItemTextChooseWidget('会员卡扣次', model.getChooseCardCount() == 0 ? '无可用扣次' : '-¥' + StringUtil.formatNum(model.getChooseCardMoney(), 2).toString() + ('抵扣' + model.getChooseCardCount().toString() + '次'), false, () {
                  if(model.customerInfoModel == null) {
                    MyToast.showToast('新用户不可选择');
                    return;
                  }
                  NavigatorUtil.getValuePush(context, MemberCardDeductionPage(consumerId: model.customerInfoModel.id, projectList: model.hasChooseProjectList, hasChooseList: model.cardHasCountList,)).then((value) {
                    if (value == null) return;
                    model.setChooseCard(value);
                  });
                }, padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                ItemTextChooseWidget('余额抵扣', model.getLeftMoneyCount() == 0 ? (model.leftMoneyList.length == 0 ? '无可用余额' : '请选择') : '抵扣' + StringUtil.formatNum(model.getLeftMoney(), 2).toString() + '元', false, () {
                  if(model.customerInfoModel == null) {
                    MyToast.showToast('新用户不可选择');
                    return;
                  }
                  NavigatorUtil.getValuePush(context, MemberBalancePage(consumerId: model.customerInfoModel.id, hasChooseList: model.hasLeftMoneyList, needMoney: model.finalGetMoney(),)).then((value) {
                    if (value == null) return;
                    model.setMemberMoneyChoose(value);
                  });
                }, padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                Visibility(
                  child:
                  _itemTextWidget('预收', StringUtil.checkEmpty(
                      model.orderSettlementDetailModel?.prepayMoney, '0')),
                  visible: double.parse(StringUtil.checkEmpty(
                      model.orderSettlementDetailModel?.prepayMoney, '0.0')) != 0,),
                ItemTextFileWidget('优惠', '请输入优惠金额', false, (value) {
                  if ((model.getAllContentMoney() - model.getChooseCardMoney() - model.getLeftMoney() - double.parse(StringUtil.checkEmpty(value?.toString(), '0.0'))) < 0) {
                    MyToast.showToast('应收不能为负');
                    model.moneyController.text = '';
                    model.handDiscount = 0.0;
                    return;
                  }
                  model.handDiscount = double.parse(StringUtil.checkEmpty(value?.toString(), '0.0'));
                  print('哈哈' + model.handDiscount.toString());
                  model.notifyListeners();
                }, inputFormatters: [PrecisionLimitFormatter(2)], editingController: model.moneyController, keyboardType: TextInputType.number, padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
              ],
            ),
          ),
          ItemTextFileWidget('订单备注', '请输入', false, (value) {
            model.remark = value;
            }, margin: EdgeInsets.fromLTRB(0, Screen.w(12), 0, 0), padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
          ItemTextChooseWidget('技师：', StringUtil.checkEmpty(model.getSaleUserName()?.toString(), '请选择'), false, () {
            showModalBottomSheet(
                backgroundColor: AppColors.color_transparent,
                context: context,
                builder: (BuildContext context) {
                  return EmployeeMuListWidget(
                    selectModelList: model.hasStoreUserListModelList,
                    getBackValue: (value) async {
                      if (value == null) return;
                      /// 获取选择的员工
                      await model.setSaleUserInfo(value);
                    },
                  );
                });
          }, margin: EdgeInsets.fromLTRB(0, 0, 0, Screen.w(12)), padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
          ItemCustomizeChildWidget('会员卡余额提醒', false, Container(child: Switch(value: model.cardRemind, activeColor: Colors.blue, // 激活时原点颜色
                  onChanged: (bool val) {
                    model.cardReminding = val;
                  },
                ),
              ), margin: EdgeInsets.fromLTRB(0, 0, 0, Screen.w(12)), padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
        ],
      ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  /// 订单内容
  Widget orderContent(BuildContext context, bool canChange, BillingContentVModel model) {
    return canChange
        /// 订单内容可修改
        ? Container(
            color: AppColors.color_ffffff,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Text('订单内容', style: CStyle.style(AppColors.color_434343, 17),),
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.hasChooseProjectList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    ProjectItemModel projectItemModel = model.hasChooseProjectList[index];
                    return _projectListWidget(context, model, index, projectItemModel,);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: Screen.h(0.5),);
                  },
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      AutoMakeLayoutWidget(
                        gradient: LinearGradient(colors: [
                          AppColors.color_fb5f65,
                          AppColors.color_f73b42
                        ]),
                        gestureTapCallback: () {
                          NavigatorUtil.getValuePush(context, ProjectListPage(hasChooseList: model.hasChooseProjectList, consumerId: model.customerInfoModel?.id,)).then((value) {
                            if (value == null) return;
                            model.setProjectList = value;
                          });
                        },
                        child: Text('选择项目', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(14)),),
                        height: Screen.h(30),
                        width: Screen.w(75),
                        bgCircle: 25,
                      ),
                      Expanded(
                        child: Text(
                          '已选' + model.getAllContentCount().toString() + '项：合计¥' + model.getAllContentMoney().toString(),
                          textAlign: TextAlign.right,
                          style: CStyle.style(AppColors.color_212121, 14),
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(Screen.w(12)),
                ),
              ],
            ),
          )
        :

        /// 订单内容不可修改
        Container(
            margin: EdgeInsets.only(bottom: Screen.w(12)),
            child: Column(
              children: <Widget>[
                Container(
                  color: AppColors.color_ffffff,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Screen.w(12)),
                        child: Text('订单内容', style: CStyle.style(AppColors.color_434343, 17),),
                      ),
                      Divider(
                        height: Screen.h(0.5),
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.hasChooseProjectList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          ProjectItemModel orderItemInfoModel = model.hasChooseProjectList[index];
                          return _projectListCantChangeWidget(orderItemInfoModel,);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(height: Screen.h(0.5),);
                        },
                      ),
                      Divider(
                        height: Screen.h(0.5),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '共' + model.hasChooseProjectList.length.toString() + '项：合计¥' + model.getAllContentMoney().toString(),
                          textAlign: TextAlign.right,
                          style: CStyle.style(AppColors.color_212121, 14),
                        ),
                        padding: EdgeInsets.all(Screen.w(12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
          );
  }

  /// item，不可以修改数据的
  Widget _projectListCantChangeWidget(ProjectItemModel orderItemInfoModel) {
    return Container(
      color: AppColors.color_ffffff,
      padding: EdgeInsets.fromLTRB(Screen.w(12), Screen.h(10), Screen.w(12), Screen.h(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(StringUtil.checkEmpty(orderItemInfoModel?.name?.toString()), style: CStyle.style(AppColors.color_666666, 14),),
          DividerUtil.HDivider(Screen.h(5)),
          Row(
            children: <Widget>[
              Text(StringUtil.checkEmpty(orderItemInfoModel?.price?.toString()), style: CStyle.style(AppColors.color_ff3c48, 14),),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: Screen.w(12)),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(orderItemInfoModel.discount == 10.00 ? '无折扣' : orderItemInfoModel.discount.toString(), style: CStyle.style(AppColors.color_666666, 14),),
                        Text('X' + orderItemInfoModel.num.toString(), style: CStyle.style(AppColors.color_666666, 14),),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }



  /// 订单项item，可以修改数据的
  Widget _projectListWidget(BuildContext context, BillingContentVModel model, int index, ProjectItemModel projectItemModel) {
    return Container(
      color: AppColors.color_ffffff,
      padding: EdgeInsets.fromLTRB(Screen.w(23.5), Screen.h(10), Screen.w(23.5), Screen.h(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(StringUtil.checkEmpty(projectItemModel?.name?.toString()), style: CStyle.style(AppColors.color_666666, 14),),
          DividerUtil.HDivider(Screen.h(5)),
          Row(
            children: <Widget>[
              Text('¥' + StringUtil.checkEmpty(projectItemModel?.price?.toString(), '0'), style: CStyle.style(AppColors.color_ff3c48, 14),),
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                    margin: EdgeInsets.only(right: Screen.w(12)),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: Screen.w(12)),
                          width: Screen.w(40),
                          decoration: BoxDecoration(
                            color: AppColors.color_ffffff,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: new Border.all(width: Screen.w(0.5), color: AppColors.color_999999),
                          ),
                          child: Text(
                            StringUtil.checkEmpty(projectItemModel?.discount?.toString()),
                            style: CStyle.style(AppColors.color_212121, 14),
                          ),
                        ),
                        Text('折', style: CStyle.style(AppColors.color_666666, 14),
                        ),
                      ],
                    )),
                onTap: () {
                  model.isAllBill = false;
                  model.setItemDiscount = 10.0;
                  CommonWidgetUtil.showCustomDialogWidget(context,
                      title: '折扣',
                      centerChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: Screen.w(12)),
                                width: Screen.w(50),
                                child: TextField(
                                  onChanged: (value) {
                                    model.setItemDiscount = double.parse(value);
                                  },
                                  inputFormatters: [PrecisionLimitFormatter(2)],
                                  keyboardType: TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(hintText: '0-10', contentPadding: EdgeInsets.all(Screen.h(5)), border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.color_999999, width: Screen.w(0.5),))),
                                ),
                              ),
                              Text('折', style: CStyle.style(AppColors.color_666666, 14),),
                            ],
                          ),
                          DividerUtil.HDivider(Screen.h(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RoundCheckBox(
                                value: model.isAllBill,
                                onChanged: (value) {model.isAllBill = value;},
                              ),
                              Text('适用整单', style: CStyle.style(AppColors.color_666666, 14),),
                            ],
                          )
                        ],
                      ), sure: () {
                    setState(() {
                      projectItemModel.discount = model.setItemDiscount;
                      if (model.isAllBill) model.setAllBill();
                      model.resetSettlementInfo();
                    });
                  });
                },
              )),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.all(Screen.w(8)),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: AppColors.color_ffffff, border: new Border.all(color: AppColors.color_f03f31), borderRadius: BorderRadius.all(Radius.circular(20))),
                            width: Screen.w(20),
                            height: Screen.w(20),
                            child: Text('——', textAlign: TextAlign.center, style: CStyle.style(AppColors.color_f03f31, 15),),
                          ),
                        ),
                        onTap: () {
                          model.deleteListNumIndex(index);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(Screen.w(15), 0, Screen.w(15), 0),
                        child: Text(StringUtil.checkEmpty(projectItemModel?.num?.toString()), style: CStyle.style(AppColors.color_434343, 14),),
                      ),
                    ],
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(Screen.w(8)),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.color_ff3c48, borderRadius: BorderRadius.all(Radius.circular(20))),
                        width: Screen.w(20),
                        height: Screen.w(20),
                        child: Text('+', textAlign: TextAlign.center, style: CStyle.style(AppColors.color_ffffff, 15),),
                      ),
                    ),
                    onTap: () {
                      model.addListNumIndex(index);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  /// 预收widget
  Widget preWidget(BillingContentVModel model, StateSetter state) {
    return Padding(
      padding: EdgeInsets.all(Screen.w(12)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text('预收仅支持提交一次，请确认后提交', textAlign: TextAlign.start, style: CStyle.style(AppColors.color_999999, 13),),
          ),
          DividerUtil.HDivider(Screen.h(12)),
          Row(
            children: <Widget>[
              Text('预收金额*', style: CStyle.style(AppColors.color_666666, 15),),
              DividerUtil.VDivider(Screen.w(12)),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: Screen.w(12)),
                  width: Screen.w(50),
                  child: TextField(
                    onChanged: (value) {
                      if(double.parse(StringUtil.checkEmpty(value?.toString(), '0.0')) > model.finalGetMoney()){
                        MyToast.showToast('预收金额不可超过订单总计');
                        model.preMoneyController.text = '';
                        model.preMoney = 0.0;
                        return;
                      }
                      model.preMoney = double.parse(value);
                    },
                    controller: model.preMoneyController,
                    inputFormatters: [PrecisionLimitFormatter(2)],
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(hintText: '请输入预收金额', hintStyle: TextStyle(fontSize: Screen.sp(12), color: AppColors.color_999999), contentPadding: EdgeInsets.all(Screen.h(5)), border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.color_999999, width: Screen.w(0.5),))),
                  ),
                ),
              ),
            ],
          ),
          DividerUtil.HDivider(Screen.h(12)),
          Row(
            children: <Widget>[
              Text('收款方式*', style: CStyle.style(AppColors.color_666666, 15),),
              Expanded(
                  child: GestureDetector(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(model.payWay == -1 ? '请选择' : Order.getPayWayName(model.payWay), style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(14)),),
                ),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: AppColors.color_transparent,
                      context: context,
                      builder: (BuildContext dialogContex) {
                        return PayWayWidget(
                          getBackValue: ((payType) {
                            print('支付方式' + payType.toString());
                            model.setPayType(payType);
                            state(() {});
                          }),
                        );
                      });
                },
              )),
              Icon(
                Icons.chevron_right,
                color: AppColors.color_999999,
              )
            ],
          )
        ],
      ),
    );
  }
}
