import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/viewmodel/customerlist_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/search_appbar_widget.dart';

import 'widget/memberinfo_list_widget.dart';

class HandleCardPage extends StatefulWidget {
  bool isOrder;

  HandleCardPage({Key key, this.isOrder = false}) : super(key: key);

  @override
  _HandleCardPageState createState() {
    return _HandleCardPageState();
  }
}

class _HandleCardPageState extends State<HandleCardPage> {
  FocusNode _focusNode = FocusNode();
  CustomerListVModel customerListVModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SearchAppBar(
        focusNode: _focusNode,
        fieldCallBack: (content) {
          customerListVModel.setKey(content);
        },
      ),
      body: Container(
          color: AppColors.color_f2f2f2,
          child: LoadingContainer<CustomerListVModel>(
            noDateWidget: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 85,
                        height: 65,
                        child: Image.asset(AppImages.nodataMemberImg),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          '暂无结果～',
                          style: TextStyle(
                              color: AppColors.color_999999, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )),
            successChild: (data) {
              customerListVModel = data;
              return ListView.separated(
                itemCount: data.list.length,
                itemBuilder: (BuildContext context, int index) {
                  CustomerInfoModel customerInfoModel =
                  data.list[index];
                  return GestureDetector(
                    child: MemInfoList(customerInfoModel),
                    onTap: () {
//                      NavigatorUtil.push(
//                          context,
//                          widget.isOrder
//                              ? new OpenOrderDetailPage()
//                              : new HandleCardStepPage());
                      Navigator.of(context).pop(customerInfoModel);
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
            model: CustomerListVModel(),
          )),
    );
  }
}
