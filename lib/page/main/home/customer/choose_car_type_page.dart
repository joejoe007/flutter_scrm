import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/util/event_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class ChooseCarTypePager extends StatefulWidget {

  CarSeriesItemModel carSeriesItemModel;
  BrandName brandName;

  ChooseCarTypePager(this.carSeriesItemModel, this.brandName);

  @override
  ChooseCarTypePagerState createState() => new ChooseCarTypePagerState(carSeriesItemModel, brandName);
}

class ChooseCarTypePagerState extends State<ChooseCarTypePager> {
  CarSeriesItemModel carSeriesItemModel;
  BrandName brandName;

  ChooseCarTypePagerState(this.carSeriesItemModel, this.brandName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new MyAppBarView(title: '选择车系'),
        backgroundColor: AppColors.color_ffffff,
        body: SafeArea(
            child: LoadingContainer<ChooseModelVModel>(
                onModelReady: (model) {
                  model.getCarModel(carSeriesItemModel.id);
                },
                successChild: (model) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ListTile(
                          title: Text(model.carModelList[index].name),
                        ),
                        onTap: () {
                          CarModelItemModel carModelItemModel = model.carModelList[index];
                          EventBusUtil.getInstance().fire(PageEvent([brandName ,carSeriesItemModel ,carModelItemModel]));
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    itemCount: model.carModelList.length,
                  );
                },
                model: ChooseModelVModel())));
  }
}
