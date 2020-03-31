import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/config.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/return_body_entity.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_project1/page/login/login_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/sp_util.dart';
import 'package:flutter_project1/widget/loading_dialog.dart';
import 'package:flutter_project1/widget/my_toast.dart';

import 'code.dart';

///http请求管理类，可单独抽取出来
///
class HttpRequest {
  static String _baseUrl = Config.inst.apiUrl;
  static HttpRequest instance;
  Dio dio;
  BaseOptions options;

  CancelToken cancelToken = CancelToken();

  static HttpRequest getInstance() {
    if (null == instance) instance = HttpRequest();
    return instance;
  }

  /*
   * config it and create
   */
  HttpRequest() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: _baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 15000,
      //Http请求头.
      headers: {"version": "1.0.0", 'Authorization': SpUtil.getString(Constant.Token_key)},
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
//      contentType: ContentType.json,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));
    if (Config.inst.debug) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("\n");
      }));
    }
  }

  void refreshToken() {

    dio.options.headers['Authorization'] = SpUtil.getString(Constant.Token_key);

  }

  /*
   * get请求
   */
  get(url,
      {queryParameters,
      options,
      cancelToken,
      bool showDialog = false,
      Function(String data, String message) successCallBack,
      Function(int code, String message) errorCallBack}) async {
    Response response;
    try {
      if (showDialog) {
        LoadingDialog.show(url);
      }
      response = await dio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
//      errorCallBack(Code.NETWORK_ERROR, '网络连接失败！');
    }
    if (showDialog) {
      LoadingDialog.close(url);
    }
    if (null != response.data) {
      ReturnBodyEntity returnBodyEntity =
          ReturnBodyEntity.fromJson(json.decode(response.data));
      if (null != returnBodyEntity) {
        switch (returnBodyEntity.code) {
          case Code.SUCCESS:
            successCallBack(
                jsonEncode(returnBodyEntity.data), returnBodyEntity.message);
            break;
          case Code.TOKEN_OUT_OF_DATA:

            /// token过期
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            MyToast.showToast(returnBodyEntity.message);
            
//            Future.delayed(Duration(milliseconds: 3000)).then((_) {
//              NavigatorUtil.push(GlobalContext.context, LoginPage());
//            });
            break;
          default:
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            MyToast.showToast(returnBodyEntity.message);
            break;
        }
      } else {
        errorCallBack(Code.NETWORK_JSON_EXCEPTION, "网络数据有问题");
        MyToast.showToast("网络数据有问题");
      }
    } else {
      errorCallBack(Code.NETWORK_ERROR, "网络不稳定，请稍后重试");
      MyToast.showToast("网络不稳定，请稍后重试");
    }
  }

  /*
   * post请求
   */
  post(url,
      {data,
      queryParameters,
      options,
      cancelToken,
      bool showDialog = false,
      Function(String data, String message) successCallBack,
      Function(int code, String message) errorCallBack}) async {
    Response response;
    try {
      if (showDialog) {
        LoadingDialog.show(url);
      }
      response = await dio.post(url,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
//      errorCallBack(Code.NETWORK_ERROR, '网络连接失败！');
    }
    if (showDialog) {
      LoadingDialog.close(url);
    }
    if (null != response.data) {
      ReturnBodyEntity returnBodyEntity =
          ReturnBodyEntity.fromJson(json.decode(response.data));
      if (null != returnBodyEntity) {
        switch (returnBodyEntity.code) {
          case Code.SUCCESS:
            successCallBack(
                jsonEncode(returnBodyEntity.data), returnBodyEntity.message);
            break;
          case Code.TOKEN_OUT_OF_DATA:

            /// token过期
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            SpUtil.remove(Constant.Token_key);
            MyToast.showToast(returnBodyEntity.message);
//            Future.delayed(Duration(milliseconds: 3000)).then((_) {
//              NavigatorUtil.push(GlobalContext.context, LoginPage());
//            });
            break;
          default:
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            MyToast.showToast(returnBodyEntity.message);
            break;
        }
      } else {
        errorCallBack(Code.NETWORK_JSON_EXCEPTION, "网络数据有问题");
        MyToast.showToast('网络数据有问题');
      }
    } else {
      errorCallBack(Code.NETWORK_ERROR, "网络不稳定，请稍后重试");
      MyToast.showToast('网络不稳定，请稍后重试');
    }
  }


  put(url,
      {data,
        queryParameters,
        options,
        cancelToken,
        bool showDialog = false,
        Function(String data, String message) successCallBack,
        Function(int code, String message) errorCallBack}) async {
    Response response;
    try {
      if (showDialog) {
        LoadingDialog.show(url);
      }
      response = await dio.put(url,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
//      errorCallBack(Code.NETWORK_ERROR, '网络连接失败！');
    }
    if (showDialog) {
      LoadingDialog.close(url);
    }
    if (null != response.data) {
      ReturnBodyEntity returnBodyEntity =
      ReturnBodyEntity.fromJson(json.decode(response.data));
      if (null != returnBodyEntity) {
        switch (returnBodyEntity.code) {
          case Code.SUCCESS:
            successCallBack(
                jsonEncode(returnBodyEntity.data), returnBodyEntity.message);
            break;
          case Code.TOKEN_OUT_OF_DATA:

          /// token过期
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            SpUtil.remove(Constant.Token_key);
            MyToast.showToast(returnBodyEntity.message);
//            Future.delayed(Duration(milliseconds: 3000)).then((_) {
//              NavigatorUtil.push(GlobalContext.context, LoginPage());
//            });
            break;
          default:
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            MyToast.showToast(returnBodyEntity.message);
            break;
        }
      } else {
        errorCallBack(Code.NETWORK_JSON_EXCEPTION, "网络数据有问题");
        MyToast.showToast('网络数据有问题');
      }
    } else {
      errorCallBack(Code.NETWORK_ERROR, "网络不稳定，请稍后重试");
      MyToast.showToast('网络不稳定，请稍后重试');
    }
  }


  delete(url,
      {data,
        queryParameters,
        options,
        cancelToken,
        bool showDialog = false,
        Function(String data, String message) successCallBack,
        Function(int code, String message) errorCallBack}) async {
    Response response;
    try {
      if (showDialog) {
        LoadingDialog.show(url);
      }
      response = await dio.delete(url,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);
//      errorCallBack(Code.NETWORK_ERROR, '网络连接失败！');
    }
    if (showDialog) {
      LoadingDialog.close(url);
    }
    if (null != response.data) {
      ReturnBodyEntity returnBodyEntity =
      ReturnBodyEntity.fromJson(json.decode(response.data));
      if (null != returnBodyEntity) {
        switch (returnBodyEntity.code) {
          case Code.SUCCESS:
            successCallBack(
                jsonEncode(returnBodyEntity.data), returnBodyEntity.message);
            break;
          case Code.TOKEN_OUT_OF_DATA:

          /// token过期
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            SpUtil.remove(Constant.Token_key);
            MyToast.showToast(returnBodyEntity.message);
//            Future.delayed(Duration(milliseconds: 3000)).then((_) {
//              NavigatorUtil.push(GlobalContext.context, LoginPage());
//            });
            break;
          default:
            errorCallBack(returnBodyEntity.code, returnBodyEntity.message);
            MyToast.showToast(returnBodyEntity.message);
            break;
        }
      } else {
        errorCallBack(Code.NETWORK_JSON_EXCEPTION, "网络数据有问题");
        MyToast.showToast('网络数据有问题');
      }
    } else {
      errorCallBack(Code.NETWORK_ERROR, "网络不稳定，请稍后重试");
      MyToast.showToast('网络不稳定，请稍后重试');
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
//    MyToast.showToast('网络连接失败！');

    /// 请求错误处理
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
}
