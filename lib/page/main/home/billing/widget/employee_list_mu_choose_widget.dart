import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/employeerlist_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/round_check_box.dart';

/// 技师多选
class EmployeeMuListWidget extends StatefulWidget {
  final GetBackValue getBackValue;
  final List<StoreUserListModel> selectModelList;

  EmployeeMuListWidget({Key key, this.selectModelList, this.getBackValue})
      : super(key: key);

  @override
  _EmployeeMuListWidgetState createState() {
    return _EmployeeMuListWidgetState();
  }
}

class _EmployeeMuListWidgetState extends State<EmployeeMuListWidget> {
  EmployeeMuListVModel employeeMuListVModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Text(
                      '员工列表',
                      style: TextStyle(
                          fontSize: Screen.sp(17), fontWeight: FontWeight.bold),
                    )),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      ),
                      right: 10,
                      top: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LoadingContainer<EmployeeMuListVModel>(
                    onModelReady: (model) {
                      employeeMuListVModel = model;
                    },
                    successChild: (data) {
                      data.setSelectModel(widget.selectModelList);
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          StoreUserListModel store = data.list[index];
                          return Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: _buildList(store));
                        },
                        itemCount: data.list.length,
                      );
                    },
                    model: EmployeeMuListVModel()),
                flex: 1,
              ),
              Container(
                  height: 70,
                  child: Center(
                    child: NormalBtnWidget(
                      tap: () {
                        /// 选中的员工
                        List<StoreUserListModel> list =
                            employeeMuListVModel.getAllPeople();
                        if (list.length != 0) {
                          widget.getBackValue(list);
                          Navigator.pop(context);
                        } else {
                          MyToast.showToast('请选择员工');
                        }
                      },
                      title: '完成',
                      width: 300,
                      height: 50,
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget _buildList(StoreUserListModel userListModel) {
    return Container(
        height: 45,
        color: AppColors.color_ffffff,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              userListModel.name,
              style: TextStyle(fontSize: Screen.sp(16)),
            ),
            RoundCheckBox(
              value: userListModel.select,
              onChanged: (value) {
                userListModel.select = value;
              },
            )
          ],
        ));
  }
}
