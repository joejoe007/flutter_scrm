import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/page/main/home/setting/memshipcardset/widget/memshipcategory_rowlist_widget.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/storeoutlist_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/bottombtn_normal_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class StoreoutAddPage extends StatefulWidget {
  final String storeOutId;

  StoreoutAddPage({Key key, this.storeOutId}) : super(key: key);

  @override
  _StoreoutAddPageState createState() {
    return _StoreoutAddPageState();
  }
}

class _StoreoutAddPageState extends State<StoreoutAddPage> {
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
        title: '新增支出',
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            color: AppColors.color_f4f4f4,
            child: ProviderWidget<StoreOutAddVModel>(
                builder: (context, data, child) {
                  return SafeArea(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: SectionTableView(
                              sectionCount: 2,
                              numOfRowInSection: (section) {
                                return (section == 0) ? 2 : 1;
                              },
                              cellAtIndexPath: (section, row) {
                                if (section == 0 && row == 1) {
                                  return MemShipCategoryRowWdiget(
                                    isMust: true,
                                    headStr: '项目金额',
                                    hintStr: '请输入',
                                    fieldCallBack: (content) {
                                      data.price = content;
                                    },
                                    keyboardType: ITextInputType.decimal,
                                  );
                                } else {
                                  return _buildListWidget(section, data);
                                }
                              },
                              headerInSection: (section) {
                                return Container(
                                  height: 10,
                                  color: AppColors.color_f4f4f4,
                                );
                              },
                              divider: Container(
                                color: AppColors.color_f4f4f4,
                                height: 1,
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
                                  data.submmitData((value) {
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ));
                },
                model: StoreOutAddVModel(storeId: widget.storeOutId))),
      )
    );
  }

  Widget _buildListWidget(int section, StoreOutAddVModel vModel) {
    return Container(
      height: 45,
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Container(
                width: 85,
                child: (section == 0)
                    ? RichText(
                        text: TextSpan(
                            text: '支出类型',
                            style: TextStyle(
                                color: AppColors.color_212121,
                                fontSize: Screen.sp(15)),
                            children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ]))
                    : Text(
                        '支出时间',
                        style: TextStyle(
                            color: AppColors.color_212121,
                            fontSize: Screen.sp(14)),
                      )),
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (section == 0) {
                          Picker(
                              adapter: PickerDataAdapter<String>(
                                pickerdata: vModel.chooseList,
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
                                vModel.setSelectType(value.first);
                              }).showModal(this.context);
                        } else {
                          DatePicker.showDatePicker(context,
                              locale: LocaleType.zh,
                              onConfirm: (DateTime time) {
                            vModel.setSelectDate(time);
                          });
                        }
                      },
                    ),
                    AutoMakeSearchBar(
                      hintText: '请选择',
                      isCanWirte: false,
                      isFromRight: true,
                      blackColor: AppColors.color_transparent,
                      isShowPrefix: false,
                      fristStr: (section == 0) ? vModel.type : vModel.beginDate,
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
            Container(
              width: 35,
              child: Icon(
                Icons.chevron_right,
                color: AppColors.color_999999,
              ),
            )
          ],
        ),
      ),
    );
  }
}
