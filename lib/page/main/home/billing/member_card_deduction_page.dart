import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/model/project_list_item_model.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/round_check_box.dart';

class MemberCardDeductionPage extends StatefulWidget {
  String consumerId;
  List<ProjectItemModel> projectList = [];
  List<MemberCardTypeModel> hasChooseList = [];

  MemberCardDeductionPage({this.consumerId, this.projectList, this.hasChooseList});

  @override
  MemberCardDeductionState createState() => new MemberCardDeductionState();
}

class MemberCardDeductionState extends State<MemberCardDeductionPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: AppColors.color_f4f4f4,
        appBar: MyAppBarView(
          title: '扣次详情',
        ),
        body: SafeArea(
            child: LoadingContainer<MemberCardReductionListVModel>(
                onModelReady: (money) {
                  money.setConsumerId(widget.consumerId);
                  money.setChooseProjectList(widget.projectList);
                  money.setHasChooseProject(widget.hasChooseList);
                },
                successChild: (model) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index == model.map.length)
                            return DividerUtil.HDivider(Screen.h(120));
                          return _builderItem(model, context, index);
                        },
                        shrinkWrap: true,
                        itemCount: model.map.length + 1,
                      ),
                      Positioned(
                        bottom: Screen.h(0),
                        left: Screen.w(0),
                        right: Screen.w(0),
                        child: Center(child:
                        AutoMakeLayoutWidget(margin: EdgeInsets.all(Screen.w(12)), gradient: LinearGradient(colors: [AppColors.color_fb5f65, AppColors.color_f73b42]), gestureTapCallback: () {
                              Navigator.of(context).pop(model.getChooseList()); // 返回选择的
                            },
                            child: Text('确定', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(17)),),
                            height: Screen.h(50),
                            width: Screen.w(300),
                            bgCircle: 25,
                            check: (model.getChooseList() != null && model.getChooseList().length > 0),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                model: MemberCardReductionListVModel())));
  }

  Widget _builderItem(MemberCardReductionListVModel model, BuildContext context, int index1) {
    return GestureDetector(
      child: Container(decoration: BoxDecoration(color: AppColors.color_ffffff, borderRadius: BorderRadius.all(Radius.circular(5))), margin: EdgeInsets.fromLTRB(Screen.w(12), Screen.w(6), Screen.w(12), Screen.w(6)),
        child: Column(
          children: <Widget>[
            _topHeader(model.map.keys.toList()[index1]),
            Divider(height: Screen.h(0.5),),
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Row(
                    children: <Widget>[
                      Text(StringUtil.checkEmpty(model?.map?.values?.toList()[index1][index]?.itemName?.toString()), style: CStyle.style(AppColors.color_666666, 14),),
                      DividerUtil.VDivider(Screen.w(12)),
                      Text('剩余' + StringUtil.checkEmpty(model?.map?.values?.toList()[index1][index]?.balance?.toString(), '0') + '次', style: CStyle.style(AppColors.color_999999, 12), textAlign: TextAlign.right,),
                      Expanded(
                        child: Text(model.map.values.toList()[index1][index].discountCount == 0 ? '' : ('本次抵扣' + StringUtil.checkEmpty(model?.map?.values?.toList()[index1][index]?.discountCount?.toString(), '0') + '次'), style: CStyle.style(AppColors.color_999999, 12), textAlign: TextAlign.right,),
                      ),
                      DividerUtil.VDivider(Screen.w(12)),
                      Container(
                        child: RoundCheckBox(
                            value: model.map.values.toList()[index1][index].choose,
                            onChanged: (value) {
                             model.compare(value, model.map.values.toList()[index1][index]);
                            },
                            stateSelf: false,),
                      )
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.map.values.toList()[index1].length,
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }

  /// top
  Widget _topHeader(String left) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(Screen.w(12)),
      child: Text(left, style: CStyle.style(AppColors.color_212121, 17),),
    );
  }
}
