import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/memshipcategory_add_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/viewmodel/memcardcategory_vmodel.dart';


import 'opencardstep_page.dart';

class OpenCardListPage extends StatefulWidget {
  dynamic userId;

  OpenCardListPage({Key key, this.userId}) : super(key: key);

  @override
  _OpenCardListPageState createState() {
    return _OpenCardListPageState();
  }
}

class _OpenCardListPageState extends State<OpenCardListPage> {
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
    OpenCardListVModel _openCardListVModel;
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '选择会员卡',
        rightTitle: '新增',
        rightCallback: () {
          NavigatorUtil.getValuePush(context, AddMemShipCategoryPage())
              .then((value) {
            _openCardListVModel.initData();
          });
        },
      ),
      body: Container(
          color: AppColors.color_f2f2f2,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                    height: 60,
                    color: AppColors.color_ffffff,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: AutoMakeSearchBar(
                        hintText: '请输入会员卡名称',
                        fieldCallBack: (content) {
                          _openCardListVModel.setKey(content);
                        },
                      ),
                    )),
                Expanded(
                  child: Container(
                    child: LoadingContainer<OpenCardListVModel>(
                        refreshType: RefreshType.normal,
                        model: OpenCardListVModel(),
                        successChild: (data) {
                          _openCardListVModel = data;
                          return ListView.separated(
                            itemCount: data.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: _cardlistWidget(data.list[index]),
                                onTap: () {
//                                NavigatorUtil.push(
//                                    context,
//                                    new MemShipCardDetailPage(
//                                      cardId: data.list[index].id,
//                                    ));
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: AppColors.color_f2f2f2,
                                height: 1,
                              );
                            },
                          );
                        }),
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
    );
  }

  Widget _cardlistWidget(MemCardCategoryListModel subModel) {
    return Container(
      height: Screen.h(80),
      color: AppColors.color_f4f4f4,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.color_e9cd97,
                AppColors.color_d7b174,

              ]),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      subModel.name,
                      style: TextStyle(
                          color: AppColors.color_212121,
                          fontSize: Screen.sp(16),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '有效期：${subModel.validValue == -1 ? '不限' :'${subModel.validValue}${(subModel.validUnit.toString() == '1')?'年':(subModel.validUnit.toString() == '2')?'个月':'天'}'}',
                      style: TextStyle(
                          color: AppColors.color_333333,
                          fontSize: Screen.sp(12)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '¥${subModel.price}',
                      style: TextStyle(
                          color: AppColors.color_212121,
                          fontSize: Screen.sp(15)),
                    ),
                    Container(
                      width: 60,
                      height: 25,
                      child: MyAutoBtn(
                        title: '开卡',
                        textFontSize: Screen.sp(12),
                        textColor: AppColors.color_ffffff,
                        backColor: AppColors.color_212121,
                        circle: 12.5,
                        onPressed: () {
                          NavigatorUtil.push(context, OpenCardStepPage(cardTypeId: subModel.id, userId: widget.userId,));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
