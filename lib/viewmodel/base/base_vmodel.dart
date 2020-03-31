import 'package:flutter/material.dart';
import 'package:flutter_project1/http/result_bean.dart';


/// BaseProvide
abstract class BaseVModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 状态设置
  ViewState _viewState = ViewState.loading;

  ViewState get viewState => _viewState;

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  setSuccess() {
    viewState = ViewState.success;
  }

  setLoading() {
    viewState = ViewState.loading;
  }

  setEmpty() {
    viewState = ViewState.empty;
  }

  setError() {
    viewState = ViewState.error;
  }

  /// 准备数据
  void onDataReady();


  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// 加载数据
  Future<ResultBean> loadListData({int pageNum}){}
}

enum ViewState {
  success, //加载成功
  loading, //加载中
  empty, //无数据
  error, //加载失败
}
