import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/round_check_box.dart';
import 'package:quiver/strings.dart';

class MemberBalancePage extends StatefulWidget {
  String consumerId;
  double needMoney;
  List<MemberCardTypeModel> hasChooseList = [];

  MemberBalancePage({this.consumerId, this.needMoney, this.hasChooseList});

  @override
  MemberBalancePageState createState() => new MemberBalancePageState();
}

class MemberBalancePageState extends State<MemberBalancePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBarView(
        title: '会员余额',
      ),
      body: SafeArea(
          child: LoadingContainer<MemberBalanceListVModel>(
              onModelReady: (model) {
                model.setConsumerId(widget.consumerId);
                model.setHasChooseList(widget.hasChooseList);
                model.totalMoney = widget.needMoney;
              },
              successChild: (model) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == model.list.length)
                          return DividerUtil.HDivider(Screen.h(120));
                        return _builderMemberBalanceWidget(context, index, model);
                      },
                      itemCount: model.list.length + 1,
                    ),
                    Positioned(
                      bottom: Screen.h(0),
                      left: Screen.w(0),
                      right: Screen.w(0),
                      child: Center(
                        child: AutoMakeLayoutWidget(margin: EdgeInsets.all(Screen.w(12)), gradient: LinearGradient(colors: [AppColors.color_fb5f65, AppColors.color_f73b42]),
                          gestureTapCallback: () {
                            Navigator.of(context).pop(model.getChooseList()); // 返回选择的余额抵扣列表
                          },
                          child: Text('确定', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(17)),), height: Screen.h(50), width: Screen.w(300), bgCircle: 25,check: (model.getChooseList() != null && model.getChooseList().length > 0),
                        ),
                      ),
                    ),
                  ],
                );
              },
              model: MemberBalanceListVModel())),
    );
  }

  Widget _builderMemberBalanceWidget(BuildContext context, int index, MemberBalanceListVModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(Screen.w(12), Screen.w(4), Screen.w(12), Screen.w(4)),
      padding: EdgeInsets.all(Screen.w(12)),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.color_e9cd97, AppColors.color_d7b174]), borderRadius: BorderRadius.all(Radius.circular(5)),),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(StringUtil.checkEmpty(model?.list[index]?.itemName), style: CStyle.style(AppColors.color_212121, 17, true),),
                    DividerUtil.VDivider(Screen.h(12)),
                    Text('余额' + StringUtil.checkEmpty(model.list[index]?.balance?.toString()) + '元', style: CStyle.style(AppColors.color_212121, 14)),
                  ],
                ),
                DividerUtil.HDivider(Screen.h(12)),
                Text(model.list[index].discountMoney == 0 ? '' : '本次使用' + StringUtil.formatNum(model.list[index].discountMoney, 2) + '元', style: CStyle.style(AppColors.color_666666, 14),)
              ],
            ),
          ),
          RoundCheckBox(
              value: model.list[index].choose,
              stateSelf: false,
              onChanged: (value) {
                if (value) {
                  if (model.totalMoney <= 0.0) {
                    MyToast.showToast('不可再选了');
                    return;
                  }
                  if (double.parse(StringUtil.checkEmpty(model.list[index]?.balance?.toString(), '0.0')) >= model.totalMoney) {
                    model.list[index].discountMoney = model.totalMoney;
                    model.totalMoney = 0.0;
                  } else {
                    model.list[index].discountMoney = double.parse(StringUtil.checkEmpty(model.list[index]?.balance?.toString(), '0.0'));
                    model.totalMoney = model.totalMoney - double.parse(StringUtil.checkEmpty(model.list[index]?.balance?.toString(), '0.0'));
                  }
                } else {
                  model.totalMoney += model.list[index].discountMoney;
                  model.list[index].discountMoney = 0.0;
                }
                model.list[index].choose = value;
                setState(() {});
              }),
        ],
      ),
    );
  }
}
