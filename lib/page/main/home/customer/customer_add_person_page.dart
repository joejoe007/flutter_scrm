import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/page/main/home/billing/widget/plate_no_keyboard.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/util/event_util.dart';
import 'package:flutter_project1/util/log_util.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/alert_dialog.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/one_choose_widget.dart';
import 'package:flutter_project1/widget/vim_widget/vim_image_page.dart';
import 'package:quiver/strings.dart';

import 'choose_car_model_page.dart';

class CustomerAddPersonPage extends StatefulWidget {

  dynamic carNum;

  dynamic consumerId;

  dynamic keyCard;

  dynamic orderId;

  CustomerAddPersonPage({this.carNum, this.consumerId, this.keyCard, this.orderId});

  @override
  CustomerAddPersonPageState createState() => new CustomerAddPersonPageState();
}

class CustomerAddPersonPageState extends State<CustomerAddPersonPage> {

  StreamSubscription<PageEvent> carTypeSub;
  CustomerAddPersonVModel _customerAddPersonVModel;

  @override
  void initState() {
    super.initState();
    carTypeSub = EventBusUtil.getInstance().on<PageEvent>().listen((data) {
      if(data != null) {
        BrandName brandName = (data.value[0] as BrandName);
        CarSeriesItemModel carSeriesItemModel = (data.value[1] as CarSeriesItemModel);
        CarModelItemModel carModelItemModel = (data.value[2] as CarModelItemModel);
        _customerAddPersonVModel.carType = StringUtil.checkEmpty(brandName.name) + StringUtil.checkEmpty(carSeriesItemModel.name) + StringUtil.checkEmpty(carModelItemModel.name);
        print('车品牌信息' + _customerAddPersonVModel.carType.toString());
        _customerAddPersonVModel.carBrandId = brandName.id;
        _customerAddPersonVModel.carSeriesId = carSeriesItemModel.id;
        _customerAddPersonVModel.carModelId = carModelItemModel.id;
        setState(() {

        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    carTypeSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarView(
          title: widget.orderId != null ? '客户信息' : (widget.carNum != null && widget.consumerId != null) ? '完善信息' : '新增客户',
        ),
        backgroundColor: AppColors.color_f4f4f4,
        body: GestureDetector(onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        } , child: LoadingContainer<CustomerAddPersonVModel>(
            onModelReady: (model) {
              _customerAddPersonVModel = model;
              if(widget.carNum != null ){
                model.keyCardController.text = widget.keyCard;
                model.getUserInfoByConsumerId(widget.consumerId, widget.carNum, orderId: widget.orderId);
              }
              model.setSuccess();
              model.tellNode.addListener(() {
                if (!model.tellNode.hasFocus) {
                  model.mobileExist();
                }
              });
              model.tellController.addListener(() {
                if (isEmpty(model.tellController.text)) {
                  return;
                }
                if (!model.tellController.text.startsWith('1')) {
                  MyToast.showToast('请输入正确的手机号');
                }
              });
            },
            successChild: (model) {
              return ListView(
                children: <Widget>[
                  DividerUtil.HDivider(Screen.h(12)),
                  widget.carNum != null ?
                  ItemCustomizeChildWidget('车牌号：', false, Text(widget.carNum, style: CStyle.style(AppColors.color_212121, 14),), padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)) : SizedBox(height: 0,),
                  ItemTextFileWidget('姓名：', '请输入姓名', widget.orderId == null, (value) {
                    model.name = value;
                  }, editingController: model.nameController, readOnly: widget.orderId != null, padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('手机号码：', '请输入手机号', false, (value) {
                    model.phone = value;
                  }, keyboardType: TextInputType.phone, readOnly: widget.orderId != null, inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')), LengthLimitingTextInputFormatter(11)],
                      focusNode: model.tellNode,
                      editingController: model.tellController,
                      padding: EdgeInsets.fromLTRB(
                          Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextChooseWidget('性别：', StringUtil.checkEmpty(model.sex, '请选择') , false, () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return OneChooseWidget(
                            title: '请选择性别',
                            data: ['男', '女'],
                            callBack: (data, index) {
                              model.sex = data;
                            },
                          );
                        });
                  }, readOnly: widget.orderId != null,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextChooseWidget('生日：', model.birthday ?? '请选择', false,
                          () {
                        CommonWidgetUtil.chooseTime(context, DateTime(1900, 1, 1), DateTime.now(), (time) {
                          model.birthday = time;
                        });
                      }, readOnly: widget.orderId != null,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('备注：', '请输入备注', false, (value) {
                    model.remark = value;
                  }, readOnly: widget.orderId != null, editingController: model.remarkController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  DividerUtil.HDivider(Screen.h(12)),
                  widget.carNum != null ?
                      SizedBox() :
                  ItemCarNoTextFileWithScanWidget('车牌号：', '请输入车牌号', true, canScan: true, onCarNoTap: (){
                    PlateNoKeyboard(
                        context: context,
                        plateNo:
                        isNotEmpty(model.carNum) ? model.carNum : '',
                        onClose: (carNum) {
                          if (carNum.toString().length == 7 ||
                              carNum.toString().length == 8) {
                            Log.info('输入的车牌号' + carNum.toString());
                            model.carNumController.text = carNum.toString();
                            model.carNum = carNum.toString();
                            _checkCarNum(model);
                          }
                        }).show();
                  }, onScanTap: () {
                    ScanCarNum.scanCarNum().then((value) {
                      if (isEmpty(value)) {
                        return;
                      }
                      Log.info('输入的车牌号' + value.toString());
                      model.carNumController.text = value;
                      model.carNum = value;
                      _checkCarNum(model);
                    });
                  },
                      editingController: model.carNumController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWithScanWidget('VIN码：', '请输入车架号', false, (value) {
                    model.vinNum = value;
                  }, scan: () {
                    NavigatorUtil.getValuePush(context, VinImagePage())
                        .then((value) {
                      if(value == null) return;
                      model.vimController.text = value;
                      model.vinNum = value;
                    });
                  }, canScan: widget.orderId == null, readOnly: widget.orderId != null,
                      inputFormatters: [LengthLimitingTextInputFormatter(17), WhitelistingTextInputFormatter(RegExp("[0-9 a-zA-Z]")),],
                      editingController: model.vimController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextChooseWidget('品牌/车型：', StringUtil.checkEmpty(model.carType, '请选择'), false, () {
                    NavigatorUtil.push(context, ChooseCarModelPager());
                  }, readOnly: widget.orderId != null,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('车辆颜色：', '请输入', false, (value) {
                    model.carColor = value;
                  }, readOnly: widget.orderId != null, inputFormatters: [WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")), LengthLimitingTextInputFormatter(5)],
                      editingController: model.carColorController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('发动机号：', '请输入', false, (value) {
                    model.engineNum = value;
                  },readOnly: widget.orderId != null,
                      inputFormatters: [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter(RegExp("[0-9 a-zA-Z]"))],
                      editingController: model.engineController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ChooseSafeTime(context, model, readOnly: widget.orderId != null,),
                  DividerUtil.HDivider(Screen.h(12)),
                  ChooseMaintainTime(context, model, readOnly: widget.orderId != null,),
                  widget.carNum != null ?
                  ItemTextFileWidget('钥匙牌号：', StringUtil.checkEmpty(model.keyCard, '请输入钥匙牌号'), false, (value) {
                    model.keyCard = value;
                  }, readOnly: widget.orderId != null, editingController: model.keyCardController, inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9 a-zA-Z]"))], padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)) : SizedBox(),
                  Visibility(child: Center(
                    child: AutoMakeLayoutWidget(
                      margin: EdgeInsets.fromLTRB(0, Screen.h(30), 0, Screen.h(30)),
                      gradient: LinearGradient(colors: [
                        AppColors.color_fb5f65,
                        AppColors.color_f73b42
                      ]),
                      gestureTapCallback: () {
                        if (isEmpty(model.name)) {
                          MyToast.showToast('姓名不能为空！');
                          return;
                        }
                        if (isEmpty(model.carNum)) {
                          MyToast.showToast('车牌号不能为空！');
                          return;
                        }
                        if (model.carNum.length != 7 &&
                            model.carNum.length != 8) {
                          MyToast.showToast('请输入正确的车牌号！');
                          return;
                        }
                        model.submitAddCustomerInfo(context, widget.carNum != null);
                      },
                      child: Text(
                        '保存',
                        style: TextStyle(
                            color: AppColors.color_ffffff,
                            fontSize: Screen.sp(17)),
                      ),
                      height: Screen.w(50),
                      width: Screen.w(300),
                      bgCircle: 25,
                    ),
                  ), visible: widget.orderId == null,),
                ],
              );
            },
            model: CustomerAddPersonVModel()),),);
  }

  /// check 车牌号是否存在
  _checkCarNum(CustomerAddPersonVModel model){
    if(model == null) return;
    model.getCarInfoByCarNum((value) {
      MyAlertDialog.showAlertDialog(
          context,
          '该车牌号已绑定在客户（' +
              (isEmpty(value.ownName.toString() +
                  value.mobile.toString())
                  ? value.carNo.toString()
                  : value.ownName.toString() +
                  value.mobile.toString()) +
              '）名下，是否与原客户解绑？',
              () {
            CustomDetailCarModel customDetailCarModel =
            CustomDetailCarModel(
                annualExpireTime: value.annualExpireTime,
                carBrandId: value.carBrandId,
                carColor: value.carColor,
                carModelId: value.carModelId,
                carSeriesId: value.carSeriesId,
                engineNo: value.engineNo,
                id: value.id,
                insuranceExpireTime:
                value.insuranceExpireTime,
                kilometers: value.kilometers,
                nextMaintainMileage:
                value.nextMaintainMileage,
                nextMaintainTime: value.nextMaintainTime,
                ownType: value.ownType,
                vin: value.vin);
            model.setChangeBindCarInfo(customDetailCarModel);
          },
          title: '车辆确认',
          cancel: () {
            CustomDetailCarModel customDetailCarModel =
            CustomDetailCarModel(
                annualExpireTime: '',
                carBrandId: '',
                carColor: '',
                carModelId: '',
                carSeriesId: '',
                engineNo: '',
                id: '',
                insuranceExpireTime: '',
                kilometers: '',
                nextMaintainMileage: '',
                nextMaintainTime: '',
                ownType: '',
                vin: '');
            model.setChangeBindCarInfo(customDetailCarModel);
          });
    });
  }
}

/// 输入框item
Widget ItemTextFileWidget(
    String title, String hintText, bool isMust, ValueChanged<String> onchange,
    {TextInputType keyboardType,
    TextEditingController editingController,
    List<TextInputFormatter> inputFormatters,
    FocusNode focusNode,
    bool readOnly = false,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin}) {
  return Container(
    margin: margin,
    padding: padding,
    height: Screen.h(45),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121, fontSize: Screen.sp(15)),
            ),
            Visibility(
              child: Text(
                '*',
                style: TextStyle(
                    color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
              ),
              visible: isMust,
            ),
          ],
        )),
        Expanded(
          child: TextField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onchange,
            readOnly: readOnly,
            focusNode: focusNode,
            controller: editingController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppColors.color_dbdbdb, fontSize: Screen.sp(14)),
            ),
          ),
          flex: 3,
        ),
      ],
    ),
  );
}

/// 文本item带扫描，车牌号
Widget ItemCarNoTextFileWithScanWidget(String title, String hintText, bool isMust,
    {TextEditingController editingController,
    bool canScan = true,
    GestureTapCallback onCarNoTap,
    Function onScanTap,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin}) {
  return Container(
    padding: padding,
    margin: margin,
    height: Screen.h(45),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121, fontSize: Screen.sp(15)),
            ),
            Visibility(
              child: Text(
                '*',
                style: TextStyle(
                    color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
              ),
              visible: isMust,
            ),
          ],
        ),
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: onCarNoTap,
            controller: editingController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: AppColors.color_dbdbdb, fontSize: Screen.sp(14))),
          ),
        ),
        Visibility(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Image.asset(
                AppImages.lightGrayScanImg,
                fit: BoxFit.contain,
                width: Screen.w(18),
                height: Screen.w(18),
              ),
              padding: EdgeInsets.all(Screen.w(5)),
            ),
            onTap: onScanTap,
          ),
          visible: canScan,
        ),
      ],
    ),
  );
}

/// 输入框item带扫描，vin
Widget ItemTextFileWithScanWidget(String title, String hintText, bool isMust,
    ValueChanged<String> onchange,
    {TextEditingController editingController,
      bool canScan = true,
      Function scan,
      bool readOnly = false,
      FocusNode focusNode,
      List<TextInputFormatter> inputFormatters,
      EdgeInsetsGeometry padding,
      GestureTapCallback onTap,
      EdgeInsetsGeometry margin}) {
  return Container(
    padding: padding,
    margin: margin,
    height: Screen.h(45),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121, fontSize: Screen.sp(15)),
            ),
            Visibility(
              child: Text(
                '*',
                style: TextStyle(
                    color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
              ),
              visible: isMust,
            ),
          ],
        ),
        Expanded(
          child: TextField(
            onTap: onTap,
            focusNode: focusNode,
            onChanged: onchange,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            controller: editingController,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: AppColors.color_dbdbdb, fontSize: Screen.sp(14))),
          ),
        ),
        Visibility(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              child: Image.asset(
                AppImages.lightGrayScanImg,
                fit: BoxFit.contain,
                width: Screen.w(18),
                height: Screen.w(18),
              ),
              padding: EdgeInsets.all(Screen.w(5)),
            ),
            onTap: scan,
          ),
          visible: canScan,
        ),
      ],
    ),
  );
}

/// 选择框item
Widget ItemTextChooseWidget(
    String title, String text, bool isMust, Function function,
    {EdgeInsetsGeometry padding, EdgeInsetsGeometry margin, bool readOnly = false}) {
  return Container(
      margin: margin,
      padding: padding,
      height: Screen.h(45),
      color: AppColors.color_ffffff,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.color_212121, fontSize: Screen.sp(15)),
                ),
                Visibility(
                  child: Text(
                    '*',
                    style: TextStyle(
                        color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
                  ),
                  visible: isMust,
                ),
              ],
            ),
            Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: AppColors.color_212121, fontSize: Screen.sp(14)),
                ),),
            Visibility(
              child: Icon(
                Icons.chevron_right,
                color: AppColors.color_999999,
              ),
              visible: !readOnly,)
          ],
        ),
        onTap: readOnly ? null : function,
      ));
}

/// 保险时间
Widget ChooseSafeTime(BuildContext context, CustomerAddPersonVModel model, {bool readOnly = false}) {
  return Container(
    padding: EdgeInsets.all(Screen.w(12)),
    color: AppColors.color_ffffff,
    child: Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if(!readOnly){
                  CommonWidgetUtil.chooseTime(context, DateTime.now(), DateTime(2100, 1, 1), (time) {
                    model.safeTime = time;
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '保险到期：',
                    style: CStyle.style(AppColors.color_212121, 15),
                  ),
                  DividerUtil.HDivider(Screen.h(5)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          model.safeTime ?? '请选择',
                          style: CStyle.style(AppColors.color_212121, 14),
                        ),
                      ),
                      Visibility(
                        child: Icon(
                          Icons.chevron_right,
                          color: AppColors.color_999999,
                        ),
                        visible: !readOnly,)
                    ],
                  )
                ],
              )),
        ),
        Container(
          width: Screen.w(30),
          height: Screen.w(30),
          alignment: Alignment.center,
          child: VerticalDivider(
            width: Screen.w(0.5),
            color: AppColors.color_999999,
          ),
        ),
        Expanded(
            child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '年检到期：',
                style: CStyle.style(AppColors.color_212121, 15),
              ),
              DividerUtil.HDivider(Screen.h(5)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      model.yearCheckTime ?? '请选择',
                      style: CStyle.style(AppColors.color_212121, 14),
                    ),
                  ),
                  Visibility(
                    child: Icon(
                    Icons.chevron_right,
                    color: AppColors.color_999999,
                  ),
                    visible: !readOnly,)
                ],
              )
            ],
          ),
          onTap: () {
            if(!readOnly){
              CommonWidgetUtil.chooseTime(context, DateTime.now(), DateTime(2100, 1, 1), (time) {
                model.yearCheckTime = time;
              });
            }
          },
        )),
      ],
    ),
  );
}

/// 保养时间
Widget ChooseMaintainTime(BuildContext context, CustomerAddPersonVModel model, {bool readOnly = false}) {
  return Container(
    padding: EdgeInsets.all(Screen.w(12)),
    color: AppColors.color_ffffff,
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      '当前公里数',
                      style: CStyle.style(AppColors.color_212121, 15),
                    ),
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: TextField(
                  controller: model.currentMController,
                  inputFormatters: [LengthLimitingTextInputFormatter(6), WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                  onChanged: (value) {
                    model.currentDriveM = value;
                  },
                  readOnly: readOnly,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入',
                      hintStyle: CStyle.style(AppColors.color_dbdbdb, 14)),
                  keyboardType: TextInputType.number,
                ),
              ),
              Text(
                '公里',
                style: CStyle.style(AppColors.color_666666, 14),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if(!readOnly){
                      CommonWidgetUtil.chooseTime(context, DateTime.now(), DateTime(2100, 1, 1), (time) {
                        model.safeTime = time;
                      });
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '下次保养公里：',
                        style: CStyle.style(AppColors.color_212121, 15),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: model.nextMController,
                        readOnly: readOnly,
                        onChanged: (value) {
                          model.nextMaintainM = value;
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(6), WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入',
                            hintStyle: CStyle.style(AppColors.color_dbdbdb, 14)),
                      ),
                    ],
                  )),
            ),
            Container(
              width: Screen.w(30),
              height: Screen.w(30),
              alignment: Alignment.center,
              child: VerticalDivider(
                width: Screen.w(0.5),
                color: AppColors.color_999999,
              ),
            ),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '下次保养时间：',
                    style: CStyle.style(AppColors.color_212121, 15),
                  ),
                  DividerUtil.HDivider(Screen.h(5)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          model.nextMaintainTime ?? '请选择',
                          style: CStyle.style(AppColors.color_212121, 14),
                        ),
                      ),
                      Visibility(
                        child: Icon(
                        Icons.chevron_right,
                        color: AppColors.color_999999,
                      ),
                        visible: !readOnly,)
                    ],
                  )
                ],
              ),
              onTap: () {
                if(!readOnly){
                  CommonWidgetUtil.chooseTime(context, DateTime.now(), DateTime(2100, 1, 1), (time) {
                    model.nextMaintainTime = time;
                  });
                }
              },
            )),
          ],
        ),
      ],
    ),
  );
}

/// 用户自定义item
Widget ItemCustomizeChildWidget(String title, bool isMust, Widget child,
    {EdgeInsetsGeometry padding, EdgeInsetsGeometry margin}) {
  return Container(
      margin: margin,
      padding: padding,
      height: Screen.h(45),
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: AppColors.color_212121, fontSize: Screen.sp(15)),
              ),
              Visibility(
                child: Text(
                  '*',
                  style: TextStyle(
                      color: AppColors.color_f73b42, fontSize: Screen.sp(15)),
                ),
                visible: isMust,
              ),
            ],
          )),
          child,
        ],
      ));
}
