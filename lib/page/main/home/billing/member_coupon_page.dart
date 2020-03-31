import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/round_check_box.dart';

class MemberCouponPage extends StatefulWidget {
  @override
  MemberCouponPageState createState() => new MemberCouponPageState();
}

class MemberCouponPageState extends State<MemberCouponPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.color_f4f4f4,
      appBar: MyAppBarView(
        title: '优惠券',
      ),
      body: SafeArea(
          child: LoadingContainer<CouponListVModel>(
              successChild: (model) {
                return Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(Screen.w(12)),
                          child: Text(
                            '每个订单仅可使用1张优惠券',
                            style: CStyle.style(AppColors.color_999999, 13),
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return _builderCanUseWidget(context, index);
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Screen.w(12)),
                          child: Text(
                            '——  不可用优惠券  ——',
                            style: CStyle.style(AppColors.color_999999, 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return _builderNoCanUseWidget(context, index);
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                        ),
                        DividerUtil.HDivider(Screen.h(130))
                      ],
                      shrinkWrap: true,
                    ),
                    Positioned(
                      bottom: Screen.h(0),
                      left: Screen.w(0),
                      right: Screen.w(0),
                      child: Center(
                        child: AutoMakeLayoutWidget(
                          margin: EdgeInsets.all(Screen.w(12)),
                          gradient: LinearGradient(colors: [
                            AppColors.color_fb5f65,
                            AppColors.color_f73b42
                          ]),
                          gestureTapCallback: () {},
                          child: Text(
                            '确定',
                            style: TextStyle(
                                color: AppColors.color_ffffff,
                                fontSize: Screen.sp(17)),
                          ),
                          height: Screen.h(50),
                          width: Screen.w(300),
                          bgCircle: 25,
                        ),
                      ),
                    ),
                  ],
                );
              },
              model: CouponListVModel())),
    );
  }
}

/// 可以用
Widget _builderCanUseWidget(BuildContext context, int index) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        Screen.w(12), Screen.w(4), Screen.w(12), Screen.w(4)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Screen.w(12)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                colors: [AppColors.color_f73b42, AppColors.color_fb5f65]),
          ),
          child: Row(
            children: <Widget>[
              Text(
                '¥11000',
                style: CStyle.style(AppColors.color_ffffff, 24, true),
              ),
              DividerUtil.VDivider(Screen.w(12)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '抵用券',
                    style: CStyle.style(AppColors.color_ffffff, 17, true),
                  ),
                  Text(
                    '有限期：2019-12-20',
                    style: CStyle.style(AppColors.color_ffffff, 13),
                  )
                ],
              )),
              Container(
                child: RoundCheckBox(value: false, onChanged: (value) {}),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.all(Screen.w(12)),
          alignment: Alignment.centerLeft,
          child: Text('可用项目：洗车、打蜡'),
        )
      ],
    ),
  );
}

/// 不可以用
Widget _builderNoCanUseWidget(BuildContext context, int index) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        Screen.w(12), Screen.w(4), Screen.w(12), Screen.w(4)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Screen.w(12)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: AppColors.color_999999),
          child: Row(
            children: <Widget>[
              Text(
                '¥11000',
                style: CStyle.style(AppColors.color_ffffff, 24, true),
              ),
              DividerUtil.VDivider(Screen.w(12)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '抵用券',
                    style: CStyle.style(AppColors.color_ffffff, 17, true),
                  ),
                  Text(
                    '有限期：2019-12-20',
                    style: CStyle.style(AppColors.color_ffffff, 13),
                  )
                ],
              )),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.all(Screen.w(12)),
          alignment: Alignment.centerLeft,
          child: Text('可用项目：洗车、打蜡'),
        )
      ],
    ),
  );
}
