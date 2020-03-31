import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/one_choose_widget.dart';
import 'package:quiver/strings.dart';
import 'customer_add_person_page.dart';

class CustomerChangePersonPage extends StatefulWidget {

  CustomDetailModel customDetailModel;
  dynamic customerId;

  CustomerChangePersonPage({this.customDetailModel, this.customerId});

  @override
  CustomerChangePersonPageState createState() => new CustomerChangePersonPageState(customDetailModel: customDetailModel, customerId: customerId);
}

class CustomerChangePersonPageState extends State<CustomerChangePersonPage> {

  CustomDetailModel customDetailModel;
  dynamic customerId;

  CustomerChangePersonPageState({this.customDetailModel, this.customerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.color_f4f4f4,
        resizeToAvoidBottomPadding: false, //输入框抵住键盘
        appBar: MyAppBarView(
          title: '修改个人信息',
          showBottomLine: false,
        ),
        body: LoadingContainer<CustomerAddPersonVModel>(
            onModelReady: (model) {
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
              return Column(
                children: <Widget>[
                  Container(
                    color: AppColors.color_ffffff,
                    margin: EdgeInsets.only(top: Screen.w(12)),
                    padding:
                        EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                    child: Column(
                      children: <Widget>[
                        ItemTextFileWidget('姓名', '请输入姓名', true, (value) {
                          model.name = value;
                        }, editingController: model.nameController),
                        ItemTextFileWidget(
                          '手机号码',
                          '请输入手机号',
                          false,
                          (value) {
                            model.phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp('[0-9]')),
                            LengthLimitingTextInputFormatter(11)
                          ],
                          focusNode: model.tellNode,
                          editingController: model.tellController,
                        ),
                        ItemTextChooseWidget(
                            '性别', StringUtil.checkEmpty(model.sex, '请选择'), false,
                            () {
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
                        }),
                        ItemTextChooseWidget(
                            '生日',
                            isEmpty(model.birthday) ? '请选择' : model.birthday,
                            false, () {
                          CommonWidgetUtil.chooseTime(
                              context, DateTime(1900, 1, 1), DateTime.now(),
                              (time) {
                            model.birthday = time;
                          });
                        })
                      ],
                    ),
                  ),
                  Expanded(
                    child: DividerUtil.HDivider(Screen.h()),
                  ),
                  AutoMakeLayoutWidget(
                    margin: EdgeInsets.only(bottom: Screen.h(30)),
                    gradient: LinearGradient(colors: [
                      AppColors.color_fb5f65,
                      AppColors.color_f73b42
                    ]),
                    gestureTapCallback: () {
                      if (isEmpty(model.name)) {
                        MyToast.showToast('姓名不能为空！');
                        return;
                      }
                      model.submitChangeCustomerInfo(context);
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
                ],
              );
            },
            model: CustomerAddPersonVModel(
                customerId: customerId, customDetailModel: customDetailModel)));
  }
}
