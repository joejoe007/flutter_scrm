import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/page/main/home/billing/billing_content_page.dart';
import 'package:flutter_project1/page/main/home/billing/widget/plate_no_keyboard.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

class EnterLicensePage extends StatefulWidget {
  @override
  EnterLicensePageState createState() => new EnterLicensePageState();
}

class EnterLicensePageState extends State<EnterLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarView(
        title: '开单',
      ),
      body: SafeArea(
          child: LoadingContainer<BillingVModel>(
              onModelReady: (model) {
                model.setSuccess();
              },
              successChild: (model) {
                return Container(
                  margin: EdgeInsets.only(top: Screen.h(20)),
                  color: AppColors.color_ffffff,
                  child: Column(
                    children: <Widget>[
                      new GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(0, 1),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(1, 2),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(2, 3),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(3, 4),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(4, 5),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(5, 6),
                              ),
                              SmallWidget(
                                num: isEmpty(model.carNum)
                                    ? ''
                                    : model.carNum.toString().substring(6, 7),
                              ),
                              SmallWidget(
                                  newCarNum: true,
                                  num: isEmpty(model.carNum)
                                      ? ''
                                      : model.carNum.toString().length == 8
                                          ? model.carNum.substring(7, 8)
                                          : ''),
                            ],
                          ),
                        ),
                        onTap: () {
                          PlateNoKeyboard(
                              context: context,
                              plateNo:
                                  isNotEmpty(model.carNum) ? model.carNum : '',
                              onClose: (carNum) {
                                if (carNum.toString().length == 7 ||
                                    carNum.toString().length == 8) {
                                  model.carNum = carNum;
                                }
                              }).show();
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Screen.h(60)),
                        child: AutoMakeLayoutWidget(
                          gradient: LinearGradient(colors: [
                            AppColors.color_fb5f65,
                            AppColors.color_f73b42
                          ]),
                          gestureTapCallback: () {
                            if (isEmpty(model.carNum)) {
                              MyToast.showToast('车牌不能为空！');
                              return;
                            }
                            if (model.carNum.length != 7 &&
                                model.carNum.length != 8) {
                              MyToast.showToast('请输入正确的车牌号！');
                              return;
                            }
                            NavigatorUtil.push(
                                context,
                                BillingContentPage(model.carNum));
                          },
                          child: Text(
                            '开单',
                            style: CStyle.style(AppColors.color_ffffff, 17),
                          ),
                          height: Screen.h(50),
                          width: Screen.w(300),
                          bgCircle: 25,
                        ),
                      )
                    ],
                  ),
                );
              },
              model: BillingVModel())),
    );
  }
}

class SmallWidget extends StatelessWidget {
  final String num;
  final bool newCarNum;

  const SmallWidget({Key key, this.num, this.newCarNum = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (newCarNum) {
      return Container(
        alignment: Alignment.center,
        width: Screen.w(30),
        height: Screen.w(30),
        decoration: BoxDecoration(
            color: AppColors.color_666666,
            borderRadius:
                new BorderRadius.all(new Radius.circular(Screen.w(7)))),
        child: Text(
          num,
          style: TextStyle(color: AppColors.color_ffffff),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        width: Screen.w(30),
        height: Screen.w(30),
        decoration: BoxDecoration(
            border: new Border.all(color: AppColors.color_666666, width: 1),
            borderRadius:
                new BorderRadius.all(new Radius.circular(Screen.w(7)))),
        child: Text(
          num,
          style: TextStyle(color: AppColors.color_333333),
        ),
      );
    }
  }
}
