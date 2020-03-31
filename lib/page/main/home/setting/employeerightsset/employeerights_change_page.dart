import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/employeerlist_vmodel.dart';
import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/automake_picker_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class EmployeeInfoEditPage extends StatefulWidget {
  final bool isEdit;
  final StoreUserListModel listModel;

  EmployeeInfoEditPage({Key key, this.isEdit = false, this.listModel})
      : super(key: key);

  @override
  _EmployeeInfoEditPageState createState() {
    return _EmployeeInfoEditPageState();
  }
}

class _EmployeeInfoEditPageState extends State<EmployeeInfoEditPage> {
  TextEditingController _editingController = TextEditingController();
  List _list = [
    ['姓名', '请输入姓名'],
    ['手机号', '请输入手机号'],
    ['角色', '']
  ];
  ChangeEmployeerVModel _changeEmployeerVModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<TextInputFormatter> telinputFormatters = <TextInputFormatter>[
      WhitelistingTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(11), //限制长度
    ];

    return Scaffold(
        appBar: MyAppBarView(
          title: widget.isEdit ? '编辑员工' : '新增员工',
          rightVisible: widget.isEdit,
          rightTitle: '删除',
          rightCallback: () {
            MyAlertDialog.showAlertDialog(context, '确定删除吗？', () {
              _changeEmployeerVModel.deleteStoreUser((value) {
                MyToast.showToast('删除成功！');
                Navigator.of(context).pop();
              });
            });
          },
        ),
        body: Container(
          color: AppColors.color_f4f4f4,
          child: SafeArea(
              child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ProviderWidget<ChangeEmployeerVModel>(
                onModelReady: (t) {
                  t.getRoleListData();
                },
                builder: (context, data, child) {
                  _changeEmployeerVModel = data;
                  if (widget.isEdit) {
                    data.selectId = widget.listModel.id.toString();
                  }
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: AppColors.color_f4f4f4,
                          child: SectionTableView(
                              headerInSection: (section) {
                                if (section == 1) {
                                  return Container(
                                      color: AppColors.color_f4f4f4,
                                      height: 50,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '登陆账号为手机号',
                                              style: TextStyle(
                                                  color: AppColors.color_999999,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              '初始密码为888888',
                                              style: TextStyle(
                                                  color: AppColors.color_999999,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ));
                                } else {
                                  return Container(
                                      height: 10,
                                      color: AppColors.color_f4f4f4);
                                }
                              },
                              divider: Container(
                                color: AppColors.color_f4f4f4,
                                height: 1,
                              ),
                              sectionCount: 2,
                              numOfRowInSection: (section) {
                                return (section == 0) ? 3 : 0;
                              },
                              cellAtIndexPath: (section, row) {
                                if (row == 2) {
                                  return _buildChooseWidget(data);
                                } else {
                                  return MemShipCategoryRowWdiget(
                                    inputFormatters: row == 1
                                        ? telinputFormatters
                                        : <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(
                                                10),
                                            //限制长度
                                          ],
                                    headStr: _list[row][0],
                                    hintStr: _list[row][1],
                                    keyboardType: row == 1
                                        ? ITextInputType.phone
                                        : ITextInputType.text,
                                    fieldCallBack: (content) {
                                      switch (row) {
                                        case 0:
                                          data.name = content;
                                          break;
                                        case 1:
                                          data.mobile = content;
                                          break;
                                        default:
                                          break;
                                      }
                                    },
                                    textfStr: (widget.isEdit)
                                        ? (row == 0
                                            ? widget.listModel.name
                                            : widget.listModel.mobile)
                                        : (row == 0 ? data.name : data.mobile),
                                  );
                                }
                              }),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Center(
                          child: NormalBtnWidget(
                            width: 300,
                            height: 50,
                            title: '保存',
                            tap: () {
                              if (widget.isEdit) {
                                _changeEmployeerVModel.selectId =
                                    widget.listModel.id;
                                data.updateStoreUser((value) {
                                  MyToast.showToast('修改成功！');
                                  Navigator.of(context).pop();
                                });
                              } else {
                                data.submmitStoreUser((value) {
                                  MyToast.showToast('添加成功！');
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
                model: ChangeEmployeerVModel()),
          )),
        ));
  }

  Widget _buildChooseWidget(ChangeEmployeerVModel vModel) {
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Container(
                width: 85,
                child: Text(
                  '角色',
                  style: TextStyle(
                      color: AppColors.color_212121, fontSize: Screen.sp(15)),
                )),
            Expanded(
              child: Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: AutoMakeSearchBar(
                    hintText: '请选择',
                    isCanWirte: false,
                    isFromRight: true,
                    blackColor: AppColors.color_transparent,
                    isShowPrefix: false,
                    editingController: _editingController,
                    fristStr: (widget.isEdit && vModel.roleName.length==0) ? widget.listModel.roleName : vModel.roleName,
                  ),
                  onTap: () {
                    if (vModel.roleNameList.length > 0) {
                      ShowPickerWidget.showPicker(context, vModel.roleNameList,
                          (Picker picker, List value) {
                        vModel.setSelectRoleId(value.first.toInt());
                        _editingController.text = vModel.roleName;
                      });
                    }
                  },
                ),
              ),
              flex: 1,
            ),
            Container(
              width: 35,
              child: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }
}
