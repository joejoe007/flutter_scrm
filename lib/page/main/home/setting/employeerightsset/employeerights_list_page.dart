import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/employeerlist_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

import 'employeerights_change_page.dart';

class EmployrightsListPage extends StatefulWidget {
  bool isChoose;
  EmployrightsListPage({Key key,this.isChoose = false}) : super(key: key);

  @override
  _EmployrightsListPageState createState() {
    return _EmployrightsListPageState();
  }
}

class _EmployrightsListPageState extends State<EmployrightsListPage> {
  EmployeerListVModel _employeerListVModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: MyAppBarView(
          title: '员工列表',
          rightTitle: '新增',
          rightCallback: () {
            NavigatorUtil.getValuePush(context, EmployeeInfoEditPage())
                .then((value) {
              _employeerListVModel.initData();
            });
          },
        ),
        body: LoadingContainer<EmployeerListVModel>(
            successChild: (data) {
              _employeerListVModel = data;
              return Container(
                color: AppColors.color_f4f4f4,
                child: SectionTableView(
                  sectionCount: 1,
                  numOfRowInSection: (section) {
                    return data.list.length;
                  },
                  cellAtIndexPath: (section, row) {
                    return GestureDetector(
                      child: _buildListWidget(data.list[row]),
                      onTap: () {
                        if(widget.isChoose) {
                          Navigator.of(context).pop(data.list[row]);
                        }else {
                          NavigatorUtil.getValuePush(
                              context,
                              EmployeeInfoEditPage(
                                isEdit: true,
                                listModel: data.list[row],
                              )).then((value) {
                            data.initData();
                          });
                        }
                      },
                    );
                  },
                  headerInSection: (section) {
                    return Container(
                      color: AppColors.color_f4f4f4,
                      height: 0.01,
                    );
                  },
                  divider: Divider(
                    color: AppColors.color_f4f4f4,
                    height: 1,
                  ),
                ),
              );
            },
            model: EmployeerListVModel()));
  }

  Widget _buildListWidget(StoreUserListModel userListModel) {
    return Container(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: AppColors.color_ffffff),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 60,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.color_fbbe50,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          (userListModel.name.length > 0)
                              ? userListModel.name.substring(0, 1)
                              : '',
                          style: TextStyle(
                              color: AppColors.color_ffffff,
                              fontWeight: FontWeight.bold,
                              fontSize: Screen.sp(18)),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                child: _buildCenterWidget(userListModel),
                flex: 1,
              ),
              Container(
                width: 40,
                child: Icon(Icons.chevron_right),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterWidget(StoreUserListModel userListModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${userListModel.name} ${userListModel.roleName}'),
        Text(userListModel.mobile),
      ],
    );
  }
}
