import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
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
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/vim_widget/vim_image_page.dart';
import 'package:quiver/strings.dart';

import 'choose_car_model_page.dart';
import 'customer_add_person_page.dart';

class CustomerChangeCarPage extends StatefulWidget {
  bool canChangeCarNo;
  dynamic customerId;
  CustomDetailModel customDetailModel;
  CustomDetailCarModel customDetailCarModel;

  CustomerChangeCarPage({
    this.canChangeCarNo = true,
    this.customDetailModel,
    this.customerId,
    this.customDetailCarModel,
  });

  @override
  CustomerChangeCarPageState createState() => new CustomerChangeCarPageState();
}

class CustomerChangeCarPageState extends State<CustomerChangeCarPage> {
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
          title: widget.canChangeCarNo ? "新增车辆" : '修改车辆',
        ),
        backgroundColor: AppColors.color_f4f4f4,
        body: GestureDetector(onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        }, child: LoadingContainer<CustomerAddPersonVModel>(
            onModelReady: (model) {
              _customerAddPersonVModel = model;
              model.setSuccess();
            },
            successChild: (model) {
              return ListView(
                children: <Widget>[
                  DividerUtil.HDivider(Screen.h(12)),
                  ItemCarNoTextFileWithScanWidget('车牌号', '请输入车牌号', true, onScanTap: () {
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
                      onCarNoTap: (){
                        if(widget.canChangeCarNo){
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
                        }
                      },
                      canScan: widget.canChangeCarNo,
                      editingController: model.carNumController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWithScanWidget('VIN码', '请输入车架号', false, (value) {
                        model.vinNum = value;
                      }, scan: () {
                        NavigatorUtil.getValuePush(context, VinImagePage()).then((value) {
                          if(value == null) return;
                          model.vimController.text = value;
                          model.vinNum = value;
                        });
                      },
                      editingController: model.vimController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(17),
                        WhitelistingTextInputFormatter(RegExp("[0-9 a-zA-Z]")),
                      ],
                      padding: EdgeInsets.fromLTRB(
                          Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextChooseWidget('品牌/车型', StringUtil.checkEmpty(model.carType, '请选择'), false, () {
                    NavigatorUtil.getValuePush(context, ChooseCarModelPager());
                  },
                      padding: EdgeInsets.fromLTRB(
                          Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('车辆颜色：', '请输入', false, (value) {
                    model.carColor = value;
                  },  inputFormatters: [WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")), LengthLimitingTextInputFormatter(5)],
                      editingController: model.carColorController,
                      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0)),
                  ItemTextFileWidget('发动机号', '请输入发动机号', false, (value) {
                    model.engineNum = value;
                  },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                        WhitelistingTextInputFormatter(RegExp("[0-9 a-zA-Z]"))
                      ],
                      editingController: model.engineController,
                      padding: EdgeInsets.fromLTRB(
                          Screen.w(12), 0, Screen.w(12), 0)),
                  ChooseSafeTime(context, model),
                  DividerUtil.HDivider(Screen.h(12)),
                  ChooseMaintainTime(context, model),
                  Center(child: AutoMakeLayoutWidget(
                    margin: EdgeInsets.fromLTRB(0, Screen.h(30), 0, Screen.h(30)),
                    gradient: LinearGradient(colors: [
                      AppColors.color_fb5f65,
                      AppColors.color_f73b42
                    ]),
                    gestureTapCallback: () {
                      if (isEmpty(model.carNum)) {
                        MyToast.showToast('车牌号不能为空！');
                        return;
                      }
                      if (model.carNum.length != 7 &&
                          model.carNum.length != 8) {
                        MyToast.showToast('请输入正确的车牌号！');
                        return;
                      }
                      model.submitAddCustomerCarInfo(context, widget.canChangeCarNo);
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
                  ),)
                ],
              );
            },
            model: CustomerAddPersonVModel(
                customerId: widget.customerId,
                customDetailModel: widget.customDetailModel,
                customDetailCarModel: widget.customDetailCarModel)),));
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
