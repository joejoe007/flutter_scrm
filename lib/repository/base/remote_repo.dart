import 'package:flutter_project1/http/http_request.dart';

/// Rest api client，依赖于[Config]
///
/// 最终调用者需要捕获[AuthException]、[NetworkException]、[BizException]和一般异常进行单独处理
/// 建议：AuthException -> 强制重新登录
/// 建议：ApiException -> 提示服务异常
/// 建议：NetworkException -> 显示网络异常页面
class RemoteRepo {
  /// 单例对象
  static final inst = RemoteRepo._();

  /// 网络请求对象
  HttpRequest _httpRequest;

  RemoteRepo._() {
    _init();
  }

  _init() {
    _httpRequest = HttpRequest.getInstance();
  }

  /// 获取网络请求对象
  HttpRequest get httpRequest {
    return _httpRequest;
  }
}
