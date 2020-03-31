import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/employeerlist_vmodel.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_toast.dart';

class EmployeeListWidget extends StatefulWidget {
  final GetBackValue getBackValue;
  final StoreUserListModel selectModel;

  EmployeeListWidget({Key key, this.selectModel, this.getBackValue})
      : super(key: key);

  @override
  _EmployeeListWidgetState createState() {
    return _EmployeeListWidgetState();
  }
}

class _EmployeeListWidgetState extends State<EmployeeListWidget> {
 bool isFrist = true;
  @override
  Widget build(BuildContext context) {
    EmployeerListVModel _employeerListVModel;
    // TODO: implement build
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
                child: LoadingContainer<EmployeerListVModel>(
                    successChild: (data) {
                      if(widget.selectModel != null && isFrist && data.list.length>0) {
                        data.setSelectModel(widget.selectModel,false);
                        isFrist = false;
                      }
                      _employeerListVModel = data;
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: _buildList(data.list[index], data));
                        },
                        itemCount: data.list.length,
                      );
                    },
                    model: EmployeerListVModel()),
                flex: 1,
              ),
              Container(
                  height: 70,
                  child: Center(
                    child: NormalBtnWidget(
                      tap: () {
                        /// 选中的员工
                        if (_employeerListVModel.selectModel != null) {
                          widget.getBackValue(_employeerListVModel.selectModel);
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

  Widget _buildList(
      StoreUserListModel userListModel, EmployeerListVModel vmodel) {
    return Container(
        height: 45,
        color: AppColors.color_ffffff,
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                userListModel.name,
                style: TextStyle(fontSize: Screen.sp(16)),
              ),
              Icon(
                !userListModel.select
                    ? Icons.radio_button_unchecked
                    : Icons.check_circle,
                color: !userListModel.select
                    ? AppColors.color_cccccc
                    : AppColors.color_maincolor,
              )
            ],
          ),
          onTap: () {
            vmodel.setSelectModel(userListModel,true);
          },
        ));
  }
}
