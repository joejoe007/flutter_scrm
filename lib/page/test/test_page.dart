import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/provider/provider_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:json_annotation/json_annotation.dart';

/// baseStatelessWidget使用，BaseRefreshListVModel带列表刷新和加载的使用

class TestBaseStatelessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarView(
          title: '测试',
        ),
        body: LoadingContainer(
            successChild: (model) {
              return EasyRefresh(
                controller: model.easyRefreshController,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: model.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: _cardlistWidget(model.list[index]),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.color_f2f2f2,
                      height: 1,
                    );
                  },
                ),
                onRefresh: () async {
                  await model.refresh();
                },
                onLoad: () async {
                  await model.loadMore();
                },
              );
            },
            model: TestBaseVMode()));
  }
}

Widget _cardlistWidget(Record subModel) {
  return Container(
    height: 140,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.color_ffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: AppColors.color_e1e2e3,
              ),
              height: 30,
              child: _cardlistSubWidget(subModel, 0),
            ),
            Expanded(
              child: _cardlistSubWidget(subModel, 1),
              flex: 1,
            ),
            Expanded(
              child: _cardlistSubWidget(subModel, 2),
              flex: 1,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _cardlistSubWidget(Record subModel, int index) {
  String beforeStr =
  index == 0 ? subModel.cardName : (index == 1) ? '现金剩余' : '项目剩余';
  String afterStr = index == 0
      ? ('卡号：${subModel.cardNo}')
      : (index == 1)
      ? ('¥${subModel.balance.toString()}')
      : '${subModel.leftTimes.toString()}次';
  return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(beforeStr), Text(afterStr)],
        ),
      ));
}

class TestBaseVMode extends BaseRefreshListVModel<Record> {
  @override
  void onDataReady() {}

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    return RepositoryCommon.getMemcardListTest(pageNum);
  }

}

/// wanandroid的banner接口请求例子，provider状态管理，bannerVModel
class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  SwiperController _swiperController;

  @override
  void initState() {
    _swiperController = new SwiperController();
    _swiperController.startAutoplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.init(context);
    return Scaffold(
        appBar: new AppBar(
          title: new Text('测试标题'),
        ),
        body: new ProviderWidget<BannerVModel>(
            onModelReady: (bannerVModel) {
              /// 获取数据
              bannerVModel.onDataReady();
            },
            builder: (context, model, child) {
              return new Column(
                children: <Widget>[
                  new GestureDetector(
                    child: new Text('点击我删除一个'),
                    onTap: () {},
                  ),
                  new Container(
                    width: Screen.w(),
                    height: Screen.h(600),
                    child: new Swiper(
                      itemBuilder: (context, index) => Image.network(
                        model.modelList[index].imagePath,
                        fit: BoxFit.fill,
                      ),
                      itemCount: model.modelList.length,
                      loop: false,
                      autoplay: false,
                      controller: _swiperController,
                      pagination: new SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.black54,
                            activeColor: Colors.white,
                          )),
                      control: new SwiperControl(),
                      scrollDirection: Axis.horizontal,
                      onTap: (index) => {},
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('搜索'),
                  )
                ],
              );
            },
            model: BannerVModel()));
  }

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }
}

/// bannerPage的VModel
class BannerVModel extends BaseRefreshListVModel {
  List<model_test> _modelTestList = [];

  List<model_test> get modelList => _modelTestList;

  @override
  void onDataReady() {
    getBannerInfo();
  }

  /// 测试接口数据
  void getBannerInfo() {
    RepositoryCommon.getTestBanner().then((result) {
      _modelTestList.clear();
      _modelTestList.addAll(result.data);
      notifyListeners();
    });
  }

  /// 修改数据
  void delete() {
    if (_modelTestList.length > 0) {
      _modelTestList.removeAt(0);
    }
    notifyListeners();
  }

}

@JsonSerializable()
class model_test extends Object {
  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  model_test(
      this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url,
      );

  factory model_test.fromJson(Map<String, dynamic> srcJson) =>
      _$model_testFromJson(srcJson);

  Map<String, dynamic> toJson() => _$model_testToJson(this);
}

model_test _$model_testFromJson(Map<String, dynamic> json) {
  return model_test(
      json['desc'] as String,
      json['id'] as int,
      json['imagePath'] as String,
      json['isVisible'] as int,
      json['order'] as int,
      json['title'] as String,
      json['type'] as int,
      json['url'] as String);
}

Map<String, dynamic> _$model_testToJson(model_test instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'imagePath': instance.imagePath,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url
    };
