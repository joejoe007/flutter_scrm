import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/itemsetlist_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'itemsetadd_page.dart';

class ItemSetListPage extends StatefulWidget {
  final bool isfromChoose;
  ItemSetListPage({Key key,this.isfromChoose = false}) : super(key: key);

  @override
  _ItemSetListPageState createState() {
    return _ItemSetListPageState();
  }
}

class _ItemSetListPageState extends State<ItemSetListPage> {
  ItemSetListVModel _itemSetListVModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '项目列表',
        rightTitle: '新增',
        rightCallback: () {
          NavigatorUtil.getValuePush(
            context, ItemsetAddPage())
              .then((value) {
                _itemSetListVModel.initData();

          });
        },
      ),
      body: Container(
        color: AppColors.color_f2f2f2,
        child: Column(
          children: <Widget>[
            Container(
                height: 60,
                color: AppColors.color_ffffff,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AutoMakeSearchBar(
                    fieldCallBack: (content) {
                      _itemSetListVModel.setName(content);
                    },
                    hintText: '输入项目名称',
                  ),
                )),
            Expanded(
              child: LoadingContainer<ItemSetListVModel>(
                  refreshType: RefreshType.withwidget,
                  successChild: (data) {
                    _itemSetListVModel = data;
                    return ListView.separated(
                      itemCount: data.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: _buildListWidget(data.list[index]),
                          onTap: () {
                            if(widget.isfromChoose) {
                              Navigator.of(context).pop(data.list[index]);/// 选择项目
                            }else {
                              NavigatorUtil.getValuePush(
                                  context, ItemsetAddPage(isChange: true,itemId: data.list[index].id.toString(),))
                                  .then((value) {
                                _itemSetListVModel.initData();

                              });
                            }

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
                  },
                  outRefreshChild: (data, refresh) {
                    String total = '0';
                    if(data.list.length>0) {
                      ItemListModel subModel  = data.list[0];
                      total = subModel.total.toString();
                    }
                    return Column(
                      children: <Widget>[
                        Container(
                            height: 35,
                            width: Screen.w(),
                            color: AppColors.color_f4f4f4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '项目总数${total}个',
                                    style: TextStyle(
                                      color: AppColors.color_666666,
                                      fontSize: 14,
                                    ),
                                  ),
                                ))),
                        Expanded(
                          child: refresh,
                          flex: 1,
                        )
                      ],
                    );
                  },
                  model: ItemSetListVModel()),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListWidget(ItemListModel listModel) {
    return Container(
      height: Screen.h(80),
      color: AppColors.color_f4f4f4,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text(listModel.name,style: TextStyle(color: AppColors.color_212121,fontWeight: FontWeight.bold,fontSize: Screen.sp(16)),), Text('工时：${listModel.hours}小时')],
                      ),
                      Text('¥${listModel.price}',style: TextStyle(color: AppColors.color_f73b42),),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Container(
                width: 45,
                child: Icon(Icons.chevron_right),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}
