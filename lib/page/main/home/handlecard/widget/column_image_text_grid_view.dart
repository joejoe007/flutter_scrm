import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';

class ColumnImgTextGridView extends StatefulWidget {
  int crossAxisCount;
  int noOrderCount;
  List<String> data;
  Function(String item, int index) itemClick;

  ColumnImgTextGridView({
    Key key,
    this.crossAxisCount,
    this.noOrderCount = 0,
    this.data,
    this.itemClick,
  }) : super(key: key);

  @override
  _ColumnImgTextGridViewState createState() => _ColumnImgTextGridViewState();
}

class _ColumnImgTextGridViewState extends State<ColumnImgTextGridView> {
  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: widget.data.length,
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.itemClick(widget.data[index], index);
              },
              child: _buildItem(index));
        });
  }

  Widget _buildItem(int index) {
    return Stack(children: <Widget>[
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            getHomeIcon(widget.data[index]),
            fit: BoxFit.cover,
            width: Screen.w(30),
            height: Screen.w(30),
          ),
          DividerUtil.HDivider(Screen.h(10)),
          new Text(
            widget.data[index],
            style: new TextStyle(
                color: AppColors.color_434343, fontSize: Screen.sp(13)),
          )
        ],
      ),
      Visibility(child: Positioned(child: Container(
        width: Screen.w(16),
        height: Screen.w(16),
        child: CircleAvatar(backgroundColor: AppColors.color_ff3c48,
          child: Text(widget.noOrderCount.toString().length < 3 ? widget.noOrderCount.toString() : '99+', style: CStyle.style(AppColors.color_ffffff, 9),),),),
        right: Screen.w(22),
        top: Screen.h(8),
      ), visible: index == 0 && widget.noOrderCount != 0,)
    ],);
  }
}

String getHomeIcon(String name) {
  String imageAsset = '';
  switch (name) {
    case '订单':
      imageAsset = AppImages.homeOrder;
      break;
    case '余额查询':
      imageAsset = AppImages.homeLeftMoneySearch;
      break;
    case '客户':
      imageAsset = AppImages.homeCustomer;
      break;
    case '门店支出':
      imageAsset = AppImages.homeStoreOut;
      break;
    case '挂帐应收':
      imageAsset = AppImages.homeAccountReceive;
      break;
    case '营业汇总':
      imageAsset = AppImages.homeBusinessSum;
      break;
    case '门店设置':
      imageAsset = AppImages.homeSetting;
      break;
    case '客户关怀':
      imageAsset = AppImages.homeOrder;
      break;
    default:
      imageAsset = AppImages.homeOrder;
      break;
  }
  return imageAsset;
}
