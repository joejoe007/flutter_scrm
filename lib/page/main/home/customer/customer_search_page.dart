import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/page/main/home/customer/customer_add_person_page.dart';
import 'package:flutter_project1/page/main/home/customer/widget/customer_list_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:quiver/strings.dart';

import 'customer_detail_page.dart';

class CustomerListSearchPage extends StatefulWidget {
  final bool isChoose;

  CustomerListSearchPage({Key key, this.isChoose = false}) : super(key: key);

  @override
  _CustomerListSearchPageState createState() {
    return _CustomerListSearchPageState();
  }
}

class _CustomerListSearchPageState extends State<CustomerListSearchPage> {
  CustomerVModel vModel;
  FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  CustomerVModel customerVModel = CustomerVModel();

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
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: AppColors.color_f4f4f4,
        appBar: MyAppBarView(
          title: '客户列表',
          rightTitle: '新增',
          rightCallback: () {
            NavigatorUtil.getValuePush(context, CustomerAddPersonPage()).then((value){
              if(null != value){
                customerVModel.onDataReady();
                customerVModel.getCustomerNumInfo();
              }
            });
          },
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  color: AppColors.color_ffffff,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(children: <Widget>[
                      AutoMakeSearchBar(
                        fieldCallBack: (content) {
                          vModel.setKey(content);
                        },
                        focusNode: _focusNode,
                        hintText: '搜索姓名、手机号、车牌号',
                        editingController: searchController,
                      ),
                      Positioned(child: GestureDetector(child: Image.asset(AppImages.lightGrayScanImg, height: Screen.w(20), width: Screen.w(20),),onTap: (){
                        ScanCarNum.scanCarNum().then((value) {
                          if (value != null) {
                            vModel.setKey(value);
                            searchController.text = value;
                            setState(() {});
                          }
                        });
                      },), right: Screen.w(18), top: 0, bottom: 0,)
                    ],)
                  )),
              Expanded(
                child: LoadingContainer<CustomerVModel>(
                    refreshType: RefreshType.withwidget,
                    onModelReady: (model){
                      customerVModel = model;
                      model.getCustomerNumInfo();
                    },
                    successChild: (model) {
                      return ListView.separated(
                        itemCount: model.list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: CustomerListWidget(model.list[index]),
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (widget.isChoose) {
                                Navigator.of(context).pop(model.list[index]);
                              } else {
                                NavigatorUtil.push(
                                    context,
                                    new CustomerDetailPage(
                                        model.list[index].id));
                              }
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return DividerUtil.HDivider(Screen.h(8));
                        },
                      );
                    },
                    outRefreshChild: (model, easyRefresh) {
                      vModel = model;
                      return Container(
                        color: AppColors.color_f2f2f2,
                        padding: EdgeInsets.fromLTRB(
                            Screen.w(11.5), 0, Screen.w(11.5), Screen.w(11.5)),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: Screen.h(40),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        '客户总人数:' +
                                            (isEmpty(model.customerNumInfoModel?.count?.toString()) ? '0' : model.customerNumInfoModel.count.toString()) +
                                            '   |   会员人数:' +
                                            (isEmpty(model.customerNumInfoModel?.memberCount?.toString()) ? '0' : model.customerNumInfoModel.memberCount.toString()),
                                        style: TextStyle(
                                          color: AppColors.color_909399,
                                          fontSize: Screen.sp(13),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                              child: easyRefresh,
                            )
                          ],
                        ),
                      );
                    },
                    model: CustomerVModel()),
              )
            ],
          ),
        ));
  }
}
