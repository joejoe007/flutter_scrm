import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/itemsetlist_vmodel.dart';
import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/precision_limit_formatter.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';

class ItemsetAddPage extends StatefulWidget {
  final bool isChange;
  final String itemId;

  ItemsetAddPage({Key key, this.isChange = false, this.itemId})
      : super(key: key);

  @override
  _ItemsetAddPageState createState() {
    return _ItemsetAddPageState();
  }
}

class _ItemsetAddPageState extends State<ItemsetAddPage> {
  List _list = [
    [true, '项目名称', '请输入项目名称'],
    [true, '项目售价', '请输入项目售价'],
    [false, '项目成本', '请输入项目成本'],
    [false, '项目工时', '请输入项目工时'],
    [false, '项目分类', '请输入项目工时'],
    [false, '排序值', '请输入排序值']
  ];

  TextEditingController _editingController = TextEditingController();
  ItemSetAddVModel _itemSetAddVModel = ItemSetAddVModel();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MyAppBarView myAppBarView = MyAppBarView(
      title: '修改项目',
      rightTitle: '删除',
      rightCallback: () {
        MyAlertDialog.showAlertDialog(context, '是否确定删除？', () {
          _itemSetAddVModel.deleteItem((getBackValue) {
            Navigator.of(context).pop();
            MyToast.showToast('删除成功！');
          });
        });
      },
    );
    return Scaffold(
      appBar: widget.isChange
          ? myAppBarView
          : MyAppBarView(
              title: '新增项目',
            ),
      body: Container(
          color: AppColors.color_f4f4f4,
          child: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ProviderWidget<ItemSetAddVModel>(
                onModelReady: (t) {
                  t.getCategoryData();
                  if (widget.isChange) {
                    /// 编辑情况
                    t.itemId = widget.itemId;
                    t.getItemDetailData();
                  }
                },
                builder: (context, data, child) {
                  _itemSetAddVModel = data;
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return (index == 4)
                                  ? _buildChooseWidget(data)
                                  : MemShipCategoryRowWdiget(
                                inputFormatters: [(index >0 && index<4)?PrecisionLimitFormatter(2):LengthLimitingTextInputFormatter(30)],
                                isMust: _list[index][0],
                                headStr: _list[index][1],
                                hintStr: _list[index][2],
                                keyboardType: (index >0 && index<4)?ITextInputType.decimal:ITextInputType.text,
                                isPrice:
                                (index == 1 || index == 2 || index == 3)
                                    ? true
                                    : false,
                                unit: (index == 3) ? '小时' : '元',
                                fieldCallBack: (content) {
                                  switch (index) {
                                    case 0:
                                      data.detailModel.name = content;
                                      break;
                                    case 1:
                                      data.detailModel.price = content;
                                      break;
                                    case 2:
                                      data.detailModel.cost = content;
                                      break;
                                    case 3:
                                      data.detailModel.hours = content;
                                      break;
                                    case 5:
                                      data.detailModel.sort = content;
                                      break;
                                  }
                                },
                                textfStr:(index == 0)
                                    ? (data.detailModel.name != null?data.detailModel.name.toString():'')
                                    : (index == 1)
                                    ? (data.detailModel.price != null?data.detailModel.price.toString():'')
                                    : (index == 2)
                                    ? (data.detailModel.cost != null?data.detailModel.cost.toString():'')
                                    : (index == 3)
                                    ? (data.detailModel.hours!=null?data.detailModel.hours.toString():'')
                                    : (index == 4)
                                    ? '${data.detailModel.firstCategoryName.toString()}-${data.detailModel.secondCategoryName.toString()}'
                                    : (data.detailModel.sort!=null?data.detailModel.sort.toString():''),
                              );
                            },
                            itemCount: _list.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(
                                color: AppColors.color_f4f4f4,
                                height: 1,
                              );
                            },
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                          height: 80,
                          child: Center(
                            child: NormalBtnWidget(
                              width: 300,
                              height: 50,
                              title: '保存',
                              tap: () {
                                if (widget.isChange) {
                                  data.updateData((getbackValue) {
                                    Navigator.of(context).pop('');
                                    MyToast.showToast('修改成功！');
                                  });
                                } else {
                                  data.submmitData((getValue) {
                                    Navigator.of(context).pop('');
                                    MyToast.showToast('添加成功！');
                                  });
                                }
                              },
                            ),
                          ))
                    ],
                  );
                },
                model: ItemSetAddVModel(),
              ),
            )
          )),
    );
  }

  Widget _buildChooseWidget(ItemSetAddVModel model) {
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
                  '项目分类',
                  style: TextStyle(
                      color: AppColors.color_212121, fontSize: Screen.sp(15)),
                )),
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Picker(
                            adapter: PickerDataAdapter<String>(
                              pickerdata: new JsonDecoder()
                                  .convert(json.encode(model.list)),
                              isArray: false,
                            ),
                            changeToFirst: true,
                            hideHeader: false,
                            cancelText: '取消',
                            confirmText: '确定',
                            confirmTextStyle: TextStyle(
                                color: AppColors.color_maincolor,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                            onConfirm: (Picker picker, List value) {
                              _editingController.text =
                                  '${picker.adapter.getSelectedValues().first}-${picker.adapter.getSelectedValues().last}';
                              model.setSelectModel(value);
                            }).showModal(this.context);
                      },
                    ),
                    AutoMakeSearchBar(
                      hintText: '请选择',
                      isCanWirte: false,
                      isFromRight: true,
                      blackColor: AppColors.color_transparent,
                      isShowPrefix: false,
                      editingController: _editingController,
                      fristStr: '${model.detailModel.firstCategoryName.toString()}-${model.detailModel.secondCategoryName.toString()}',
                    ),
                  ],
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
