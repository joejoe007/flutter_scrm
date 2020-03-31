import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/project_list_item_model.dart';
import 'package:flutter_project1/page/main/home/setting/itemset/itemsetadd_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class ProjectListPage extends StatefulWidget {
  List<ProjectItemModel> hasChooseList = [];
  dynamic consumerId;

  ProjectListPage({this.hasChooseList, this.consumerId});

  @override
  ProjectListPageState createState() => new ProjectListPageState();
}

class ProjectListPageState extends State<ProjectListPage> with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();
  bool sheetVisibility = false;
  ProjectListVModel model;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBarView(
        title: '项目列表',
        rightTitle: '新增',
        rightCallback: () {
          NavigatorUtil.getValuePush(context, ItemsetAddPage()).then((value){
            if(value == null) return;
            model.loadProjectList(id: widget.consumerId);
          });
        },
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: LoadingContainer<ProjectListVModel>(
              onModelReady: (model) {
                this.model = model;
                model.setHasChooseList(widget.hasChooseList);
                model.loadProjectList(id: widget.consumerId);
              },
              successChild: (model) {
                return Container(
                    color: AppColors.color_f4f4f4,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      color: AppColors.color_ffffff,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: AutoMakeSearchBar(
                                          fieldCallBack: (content) {
                                            model.searchKey(content);
                                          },
                                          focusNode: _focusNode,
                                          hintText: '请输入关键词搜索',
                                        ),
                                      )),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: model.list.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        ProjectItemModel projectItemModel = model.list[index];
                                        return model.showSearch ? projectItemModel.searchShow ? projectListWidget(model, index, projectItemModel,): SizedBox(height: 0,) : projectListWidget(model, index, projectItemModel,);
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        ProjectItemModel projectItemModel = model.list[index];
                                        return model.showSearch ? projectItemModel.searchShow ? Divider(height: Screen.h(0.5)) : SizedBox(height: 0,) : Divider(height: Screen.h(0.5),);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                child: Positioned(
                                  child: _showHasChoose(context, model),
                                ),
                                visible: sheetVisibility,
                              )
                            ],
                          ),
                        ),
                        Divider(height: Screen.h(0.5)),
                        Container(
                          color: AppColors.color_ffffff,
                          height: Screen.h(50),
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(
                              Screen.w(12), 0, Screen.w(12), 0),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Text(
                                  '已选' + model.getAllContentCount().toString() + '项：合计¥' + StringUtil.formatNum(model.getAllContentMoney(), 2), style: CStyle.style(AppColors.color_212121, 14),
                                ),
                                onTap: () {
                                  if(model.getAllContentCount() > 0){
                                    setState(() {
                                      sheetVisibility = !sheetVisibility;
                                    });
                                  }
                                },
                              ),
                              Visibility(child:Icon(Icons.keyboard_arrow_up), visible: model.getAllContentCount() > 0),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoMakeLayoutWidget(
                                    gestureTapCallback: () {
                                      Navigator.of(context).pop(model.hasChooseProject());
                                    },
                                    width: Screen.w(75),
                                    height: Screen.h(30),
                                    bgCircle: 17,
                                    check: model.getAllContentCount() > 0,
                                    bgColor: AppColors.color_ff3b25,
                                    child: Text('选好了', style: CStyle.style(AppColors.color_ffffff, 14),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
              model: ProjectListVModel())),
    );
  }

  /// item
  Widget projectListWidget(ProjectListVModel model, int index, ProjectItemModel projectItemModel) {
    return Container(
      color: AppColors.color_ffffff,
      padding: EdgeInsets.fromLTRB(Screen.w(23.5), Screen.h(10), Screen.w(23.5), Screen.h(10)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtil.checkEmpty(projectItemModel?.name?.toString()), style: CStyle.style(AppColors.color_666666, 14),),
              DividerUtil.VDivider(Screen.w(5)),
              Visibility(
                child: AutoMakeLayoutWidget(
                  width: Screen.w(30),
                  height: Screen.h(18),
                  bgCircle: 5,
                  gradient: LinearGradient(colors: [AppColors.color_f2c97f, AppColors.color_cb993e]),
                  child: Text('会员', style: TextStyle(color: AppColors.color_ffffff, fontSize: Screen.sp(12)),),
                ),
                visible: projectItemModel.showCardMember,
              ),
            ],
          ),
          DividerUtil.HDivider(Screen.h(5)),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('¥' + StringUtil.checkEmpty(projectItemModel?.price?.toString(), '0'), style: CStyle.style(AppColors.color_ff3c48, 14),),
              ),
              Row(
                children: <Widget>[
                  Visibility(
                    child: Row(
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
                            if (sheetVisibility == true && model.hideSheet() == true) {
                              setState(() {
                                sheetVisibility = !sheetVisibility;
                              });
                            }
                          },
                        ),
                        Container(padding: EdgeInsets.fromLTRB(Screen.w(15), 0, Screen.w(15), 0), child: Text(projectItemModel.num.toString(), style: CStyle.style(AppColors.color_434343, 14),),
                        ),
                      ],
                    ),
                    visible: projectItemModel.num != 0,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(Screen.w(8)),
                      child: Container(alignment: Alignment.center, decoration: BoxDecoration(color: AppColors.color_ff3c48, borderRadius: BorderRadius.all(Radius.circular(20))),
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
          )
        ],
      ),
    );
  }

  /// 显示已经选择的
  Widget _showHasChoose(BuildContext context, ProjectListVModel model) {
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
          Container(
            decoration: BoxDecoration(color: AppColors.color_ffffff, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            height: Screen.h(50),
            child: Stack(
              children: <Widget>[
                Center(child: Text('已选', style: TextStyle(fontSize: Screen.sp(17), fontWeight: FontWeight.bold),)),
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
                  ProjectItemModel projectItemModel = model.list[index];
                  if (projectItemModel.num == 0) {
                    return SizedBox();
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: projectListWidget(model, index, projectItemModel,
                    ),
                  );
                },
                itemCount: model.list.length,
                separatorBuilder: (BuildContext context, int index) {
                  ProjectItemModel projectItemModel = model.list[index];
                  if (projectItemModel.num == 0) {
                    return SizedBox();
                  }
                  return Divider(height: Screen.h(0.5),);
                },
              ),
              color: AppColors.color_ffffff,
            ),
          ),
        ],
      ),
    );
  }
}
