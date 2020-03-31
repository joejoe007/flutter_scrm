import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'choose_car_type_page.dart';

class ChooseCarSeriesPager extends StatefulWidget {

  BrandName brandName;

  ChooseCarSeriesPager(this.brandName);

  @override
  ChooseCarSeriesPagerState createState() => new ChooseCarSeriesPagerState(brandName);
}

class ChooseCarSeriesPagerState extends State<ChooseCarSeriesPager> {

  BrandName brandName;

  ChooseCarSeriesPagerState(this.brandName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new MyAppBarView(title: '选择车型'),
        backgroundColor: AppColors.color_ffffff,
        body: SafeArea(
            child: LoadingContainer<ChooseSeriesVModel>(
                onModelReady: (model) {
                  model.getCarSeries(brandName.id);
                },
                successChild: (model) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ListTile(
                          title: Text(model.seriesList[index].name),
                        ),
                        onTap: () {
                          CarSeriesItemModel seriesModel =
                              model.seriesList[index];
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseCarTypePager(seriesModel, brandName)));

                        },
                      );
                    },
                    itemCount: model.seriesList.length,
                  );
                },
                model: ChooseSeriesVModel())));
  }
}
