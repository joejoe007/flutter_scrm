import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/search_appbar_widget.dart';
import 'package:quiver/strings.dart';

/// 车辆搜索界面
class CarListSearchPage extends StatefulWidget {
  @override
  _CarListSearchPageState createState() {
    return _CarListSearchPageState();
  }
}

class _CarListSearchPageState extends State<CarListSearchPage> {
  CarListVModel vModel;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.color_f4f4f4,
      appBar: SearchAppBar(
        fieldCallBack: (content) {
          vModel.setKey(key: content);
        },
      ),
      body: LoadingContainer<CarListVModel>(
          refreshType: RefreshType.normal,
          onModelReady: (model) {
            vModel = model;
          },
          successChild: (model) {
            return ListView.separated(
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
               return index == 0 ?
                Column(children: <Widget>[
                  DividerUtil.HDivider(Screen.h(12)),
                  GestureDetector(
                    child: getCarItemWidget(model.list[index]),
                    onTap: () {
                      Navigator.of(context).pop(model.list[index].carNo);
                    },
                  )
                ],) :
                GestureDetector(
                  child: getCarItemWidget(model.list[index]),
                  onTap: () {
                    Navigator.of(context).pop(model.list[index].carNo);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return DividerUtil.HDivider(Screen.h(8));
              },
            );
          },
          model: CarListVModel()),
    );
  }
}

/// 车辆item界面
Widget getCarItemWidget(CarItemInfoModel carItemInfoModel) {
  return Container(
    padding: EdgeInsets.all(Screen.w(10)),
    decoration: BoxDecoration(
      color: AppColors.color_ffffff,
      borderRadius: new BorderRadius.all(new Radius.circular(5)),
    ),
    height: Screen.h(80),
    child: Row(
      children: <Widget>[
        Container(
            width: Screen.w(40),
            height: Screen.w(40),
            child: CircleAvatar(
              child: Text(
                isEmpty(carItemInfoModel?.customerName?.toString())
                    ? ''
                    : carItemInfoModel.customerName.toString().substring(0, 1),
                style: TextStyle(
                    fontSize: Screen.sp(18),
                    color: AppColors.color_ffffff,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColors.color_83a4F1,
            )),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: Screen.w(11)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isEmpty(carItemInfoModel?.carNo?.toString()) ? '未知' : carItemInfoModel.carNo.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.color_212121,
                      fontSize: Screen.sp(16)),
                  overflow: TextOverflow.ellipsis,
                ),
                DividerUtil.HDivider(Screen.h(3)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    (isEmpty(carItemInfoModel?.customerName?.toString()) ? '' : carItemInfoModel.customerName.toString() + ' ') +
                        (isEmpty(carItemInfoModel?.telNo?.toString()) ? '' : carItemInfoModel.telNo.toString()),
                    style: TextStyle(
                        color: AppColors.color_666666, fontSize: Screen.sp(12)),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          flex: 1,
        ),
      ],
    ),
  );
}
