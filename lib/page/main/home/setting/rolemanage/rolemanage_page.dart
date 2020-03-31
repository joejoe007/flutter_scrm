import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/rolemenu_model.dart';
import 'package:flutter_project1/viewmodel/rolemenu_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class RoleManagePage extends StatefulWidget {
  RoleManagePage({Key key}) : super(key: key);

  @override
  _RoleManagePageState createState() {
    return _RoleManagePageState();
  }
}

class _RoleManagePageState extends State<RoleManagePage> {
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
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '角色权限',
      ),
      body: Container(
          color: AppColors.color_ffffff,
          child: LoadingContainer<RoleMenVModel>(
              successChild: (data) {
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: _buildListWidget(data),
                        flex: 1,
                      ),
                      Container(
                          height: 80,
                          color: AppColors.color_ffffff,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: FlatButton.icon(
                                    onPressed: () {
                                      data.setAllSelect(!data.isAllSelect);
                                    },
                                    icon: Icon(
                                      data.isAllSelect
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: data.isAllSelect
                                          ? AppColors.color_maincolor
                                          : AppColors.color_cccccc,
                                    ),
                                    label: Text('全选',style: TextStyle(color: AppColors.color_666666,fontSize: 15),),
                                    splashColor: AppColors.color_transparent,
                                    highlightColor: AppColors.color_transparent,
                                  ),
                                ),
                                NormalBtnWidget(
                                  title: '确定',
                                  width: 205,
                                  height: 40,
                                  tap: () {
                                    data.submmit((value){
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              },
              model: RoleMenVModel())),
    );
  }

  Widget _buildListWidget(RoleMenVModel vModel) {
    return Container(
        color: AppColors.color_f4f4f4,
        child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              color: AppColors.color_ffffff,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: _buildLeftListWidget(vModel),
                  ),
                  Container(
                    width: 1,
                    color: AppColors.color_f4f4f4,
                  ),
                  Expanded(
                    child: Container(
                      child: _buildRightListWidget(vModel),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )));
  }

  Widget _buildLeftListWidget(RoleMenVModel vModel) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        RoleMenuModel subModel = vModel.list[index];
        return GestureDetector(
          child: Container(
              color: vModel.selectTag == index
                  ? AppColors.color_fbecec
                  : AppColors.color_ffffff,
              child: Container(
                child: Center(
                  child: Text(
                    subModel.name,
                    style: TextStyle(
                        color: vModel.selectTag == index
                            ? AppColors.color_f73b42
                            : AppColors.color_212121,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                height: 45,
              )),
          onTap: () {
            vModel.setSelectTag(index);
          },
        );
      },
      itemCount: vModel.list.length,
    );
  }

  Widget _buildRightListWidget(RoleMenVModel vModel) {
    return ListView.separated(
      itemCount: vModel.list.length > 0
          ? vModel.list[vModel.selectTag].list.length
          : 0,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            height: 45,
            color: AppColors.color_ffffff,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    vModel.list.length > 0
                        ? vModel.list[vModel.selectTag].list[index].name
                            .toString()
                        : '',
                    style:
                        TextStyle(color: AppColors.color_666666, fontSize: 14),
                  ),
                  Container(
                    width: 40,
                    child: vModel.list.length > 0
                        ? Icon(
                            (vModel.list[vModel.selectTag].list[index].isSelect)
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: (vModel.list[vModel.selectTag].list[index]
                                    .isSelect)
                                ? AppColors.color_maincolor
                                : AppColors.color_cccccc,
                          )
                        : Text(''),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            vModel.setSelectModel(vModel.list[vModel.selectTag].list[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: AppColors.color_f2f2f2,
          height: 1,
        );
      },
    );
  }
}
