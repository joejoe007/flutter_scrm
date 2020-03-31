import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/api.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/vim_mode.dart';
import 'package:flutter_project1/util/encode_util.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

import '../../main.dart';
import 'common_loading_dialog.dart';

class VinImagePage extends StatefulWidget {
  @override
  _VinImagePageState createState() => _VinImagePageState();
}

class _VinImagePageState extends State<VinImagePage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    /// 从可用摄像头列表中获取特定摄像头。
    final firstCamera = cameras.first;

    // 要显示摄像机的当前输出
    // 创建一个CameraController
    _controller = CameraController(
      // 从可用摄像头列表中获取特定摄像头
      firstCamera,
      // 定义要使用的分辨率。
      ResolutionPreset.medium,
    );

    // 接下来，初始化控制器。 这将返回一个Future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new CommonLoadingDialog(
                  //调用对话框
                  text: '解析中...',
                );
              });
          try {
            // 确保已初始化摄像机。
            await _initializeControllerFuture;
            final path = join(
                (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
            await _controller.takePicture(path);
            EncodeUtil.image2Base64(path).then((data) {
              submitImageBase64(data).then((value) {
                Navigator.pop(context); //关闭对话框
                if (value == null) {
                  MyToast.showToast('解析失败，请重试！');
                  return;
                }
                print('vin' + value?.vin?.toString());
                if (value?.success?.toString() == 'true') {
                  /// 成功
                  Navigator.of(context).pop(value.vin);
                } else {
                  /// 失败
                  MyToast.showToast('解析失败，请重试！');
                }
              });
            });
          } catch (e) {
            print(e);
          }
        },
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

/// 提交照片的base64
Future<VimImageModel> submitImageBase64(String baseImage) async {
  Response response;
  Dio dio = Dio()..options.responseType = ResponseType.plain;
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
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
  Options options = Options(headers: {
    'Authorization': 'APPCODE ' + Constant.VIN_APP_CODE,
    'X-Ca-Nonce': DateUtil.getNowDateMs(),
  });
  var image = {'image': baseImage};
  try {
    response =
        await dio.post(Api.VIM_IMAGE_URL, options: options, data: image);
    VimImageModel imageCarModel =
        VimImageModel.fromJson(json.decode(response.data.toString()));
    return imageCarModel;
  } catch (e) {
    print(e);
    return null;
  }
}
