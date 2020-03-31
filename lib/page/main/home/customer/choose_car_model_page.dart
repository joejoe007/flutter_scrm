import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/page/main/home/customer/choose_car_series_page.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'choosecar/index_bar.dart';
import 'choosecar/suspension_view.dart';

class ChooseCarModelPager extends StatefulWidget {
  @override
  _ChooseCarModelPagerState createState() => _ChooseCarModelPagerState();
}

class _ChooseCarModelPagerState extends State<ChooseCarModelPager> {
  Map<String, int> _suspensionSectionMap = Map();
  ScrollController _scrollController;
  String _suspensionTag = "";

  bool _isShowIndexBarHint = false;
  String _indexBarHint = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onIndexBarTouch(IndexBarDetails model) {
    setState(() {
      _indexBarHint = model.tag;
      _isShowIndexBarHint = model.isTouchDown;
      int offset = _suspensionSectionMap[model.tag];
      if (offset != null) {
        _scrollController.jumpTo(offset.toDouble());
      }
    });
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  void _onSusSectionInited(Map<String, int> map) => _suspensionSectionMap = map;

  Widget _buildListItem(ChooseCarModelVModel models, int index) {
    BrandName model = models.brandList[index];
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: Container(
            alignment: Alignment.centerLeft,
            height: Screen.h(40),
            color: Color(0xfff3f4f5),
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              model.tagIndex,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xff999999),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Screen.h(50),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChooseCarSeriesPager(model)));
                },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new MyAppBarView(title: '选择品牌'),
        backgroundColor: AppColors.color_ffffff,
        body: SafeArea(
            child: LoadingContainer<ChooseCarModelVModel>(
                onModelReady: (model) {},
                successChild: (model) {
                  return Stack(
                    children: <Widget>[
                      SuspensionView(
                        data: model.brandList,
                        contentWidget: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: model.brandList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildListItem(model, index);
                          },
                        ),
                        suspensionWidget: Container(
                          height: Screen.h(40),
                          padding: const EdgeInsets.only(left: 15.0),
                          color: Color(0xfff3f4f5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$_suspensionTag',
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff999999),
                            ),
                          ),
                        ),
                        controller: _scrollController,
                        suspensionHeight: Screen.h(40).toInt(),
                        itemHeight: Screen.h(50).toInt(),
                        onSusTagChanged: _onSusTagChanged,
                        onSusSectionInited: _onSusSectionInited,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IndexBar(
                          data: model.indexTagList,
                          onTouch: _onIndexBarTouch,
                        ),
                      ),
                      Offstage(
                        offstage: !_isShowIndexBarHint,
                        child: Center(
                          child: Card(
                            color: Colors.black87,
                            child: Container(
                              alignment: Alignment.center,
                              width: 72.0,
                              height: 72.0,
                              child: Text(
                                '$_indexBarHint',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
                model: ChooseCarModelVModel())));
  }
}
