import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/memcardcategory_vmodel.dart';

import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/loading_container.dart';

import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'memshipcategory_add_page.dart';

class MemShipSetListPage extends StatefulWidget {
  MemShipSetListPage({Key key}) : super(key: key);

  @override
  _MemShipSetListPageState createState() {
    return _MemShipSetListPageState();
  }
}

class _MemShipSetListPageState extends State<MemShipSetListPage> {
  MemCardCagtegoryVModel _memCardCagtegoryVModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '会员卡设置',
        rightTitle: '新增',
        rightCallback: () {
          NavigatorUtil.getValuePush(context, AddMemShipCategoryPage())
              .then((value) {
            _memCardCagtegoryVModel.initData();
          });
        },
      ),
      body: Container(
          color: AppColors.color_f2f2f2,
          child: LoadingContainer<MemCardCagtegoryVModel>(
            refreshType: RefreshType.normal,
            successChild: (data) {
              _memCardCagtegoryVModel = data;
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: _buildListWidget(data.list[index]),
                      onTap: () {
                        NavigatorUtil.getValuePush(
                            context,
                            new AddMemShipCategoryPage(
                              isChange: true,
                              cardTypeId: data.list[index].id.toString(),
                            )).then((value) {

                          _memCardCagtegoryVModel.initData();
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.color_f2f2f2,
                      height: 1,
                    );
                  },
                  itemCount: data.list.length);
            },
            model: MemCardCagtegoryVModel(),
          )),
    );
  }

  Widget _buildListWidget(MemCardCategoryListModel subModel) {
    return Container(
      height: 170,
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        subModel.name,
                        style: TextStyle(
                            fontSize: Screen.sp(17),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              subModel.status == 0 ? '正常' : '已下架',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.color_212121, width: 1),
                              borderRadius: BorderRadius.circular(2)),
                        )),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppColors.color_f2f2f2,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: Container(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '售价：¥${subModel.price}',
                      style: TextStyle(
                          fontSize: Screen.sp(15), fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
              Container(
                  height: 30,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          '有效期：${subModel.validValue == -1 ? '永久有效' : '${subModel.validValue}${subModel.validUnit == 1 ? '年' : (subModel.validUnit == 2) ? '月' : '日'}'}'),
                    ),
                  )),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          height: 25,
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton.icon(
                                  onPressed: () {
                                    MyAlertDialog.showAlertDialog(
                                        context, '确定删除吗？', () {
                                          _memCardCagtegoryVModel.selectId = subModel.id;
                                          _memCardCagtegoryVModel.status = '1';
                                          _memCardCagtegoryVModel.changeCardTypeStatus();

                                    });
                                  },
                                  icon: Image.asset(
                                    AppImages.blackdelete,
                                    width: 20,
                                    height: 20,
                                  ),
                                  label: Text('删除')))),
                      Container(
                          height: 25,
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton.icon(
                                  onPressed: () {
                                    MyAlertDialog.showAlertDialog(
                                        context,
                                        (subModel.status == 0)
                                            ? '确定下架吗？'
                                            : '确认上架吗？',
                                        () {

                                          _memCardCagtegoryVModel.selectId = subModel.id;
                                          _memCardCagtegoryVModel.status =(subModel.status == 0)?'2':'0';
                                          _memCardCagtegoryVModel.changeCardTypeStatus();

                                        });
                                  },
                                  icon: Image.asset(
                                    (subModel.status == 0)?AppImages.blackdownload:AppImages.blackup,
                                    color: AppColors.color_333333,
                                    width: 20,
                                    height: 20,
                                  ),
                                  label: Text(
                                      (subModel.status == 0) ? '下架' : '上架')))),
                      Container(
                          height: 25,
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton.icon(
                                  onPressed: () {
                                    NavigatorUtil.getValuePush(
                                        context,
                                        new AddMemShipCategoryPage(
                                          isChange: true,
                                          cardTypeId: subModel.id.toString(),
                                        )).then((value) {

                                      _memCardCagtegoryVModel.initData();
                                    });
                                  },
                                  icon: Image.asset(
                                    AppImages.blackedit,
                                    width: 20,
                                    height: 20,
                                  ),
                                  label: Text('编辑')))),
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(subModel.status == 0
                  ? AppImages.memcardNomal
                  : AppImages.memcardShelves),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
