import 'package:flutter/services.dart';

class ScanCarNum {
  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel('com.chuangzhihui.scrm/plugin');

  // 提示测试
  static showToast(){
    jumpPlugin.invokeMethod("toast");
  }

  // 调用原生扫描二维码
  static Future<String> scanCarNum() async {
    String result = await jumpPlugin.invokeMethod('usrScan');
    return result;
  }

  // 跳转到原生直播
  static jumpToLive(){

  }

}
