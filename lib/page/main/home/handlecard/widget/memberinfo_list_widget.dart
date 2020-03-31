import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/util/screen.dart';

/// 客户信息
class MemInfoList extends StatefulWidget {
  final CustomerInfoModel infoModel;
  final bool isFromList;

  MemInfoList(this.infoModel, {Key key, this.isFromList = true})
      : super(key: key);

  @override
  _MemInfoListState createState() {
    return _MemInfoListState();
  }
}

class _MemInfoListState extends State<MemInfoList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Column column = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMemInfoWidget(),
          Text(_setCarNoString()),
        ]);
    return Container(
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            child: widget.infoModel.name.length > 0
                ? _buildHeadNameWidget(widget.infoModel.name)
                : _buildHolderImgWidget(),

//            Padding(
//                padding: EdgeInsets.all(10),
//                child: ClipRRect(
//                    borderRadius: BorderRadius.circular(25),

//                  FadeInImage.assetNetwork(
//                    placeholder: AppImages.memPlaceholder,
//                    image: 'http://www.itying.com/images/flutter/1.png',
//                    fit: BoxFit.cover,
//                  ),
//                    )),
          ),
          Expanded(
            child: Container(
              child: widget.isFromList
                  ? column
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_setCarNoString()),
                        _buildMemInfoWidget(),
                      ],
                    ),
            ),
            flex: 1,
          ),
          Visibility(
            child: Container(
              width: 45,
              child: Icon(Icons.chevron_right),
            ),
            visible: !widget.isFromList ? true : false,
          )
        ],
      ),
    );
  }

  Widget _buildMemInfoWidget() {
    return Row(
      children: <Widget>[
        Text(widget.infoModel.name == null ? '未知' : widget.infoModel.name),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
              (widget.infoModel.mobile != null) ? widget.infoModel.mobile : ''),
        ),
        Visibility(
          child: Container(
            height: 20,
            width: 40,
            child: Text(
              '会员',
              style: TextStyle(color: AppColors.color_ffffff),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: AppColors.color_999999,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
//          visible: widget.infoModel.customerType == 1 ? true : false,
          visible:  false,
        )
      ],
    );
  }

  String _setCarNoString() {
    String carNos = '';
    for (CustomListCarModel carModel in widget.infoModel.cars) {
      carNos = (carNos == '')
          ? carNos + carModel.carNo
          : carNos + '、' + carModel.carNo;
    }
    return carNos;
  }

  Widget _buildHeadNameWidget(String name) {
    return Center(
      child: Container(
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
                  (name.length > 0) ? name.substring(0, 1) : '',
                  style: TextStyle(
                      color: AppColors.color_ffffff,
                      fontWeight: FontWeight.bold,
                      fontSize: Screen.sp(18)),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildHolderImgWidget() {
    return Center(
      child: Container(
          width: 60,
          height: 60,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.color_d4d4d4,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: Image.asset(AppImages.holderMemImg),
                )
              ),
            ),
          )),
    );
  }
}
