import 'dart:io';

import 'package:flutter_project1/model/version_info_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:package_info/package_info.dart';

typedef versionState = Function(
    VersionState versionState, VersionInfoModel versionInfoModel);

class MainVModel extends BaseRefreshListVModel {
  @override
  void onDataReady() {}

  void getVersionInfo(versionState state) {
    Map<String, dynamic> _params = Map();
    _params['osType'] = Platform.isIOS ? 0 : 1;
    RepositoryCommon.getVersionInfo(_params).then((value) {
      if (value.data == null) return;
      VersionInfoModel versionInfoModel = value.data;
      int minVersion = int.parse(versionInfoModel.miniCode);
      int newVersion = versionInfoModel.versionCode;
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        int currentNumber = int.parse(packageInfo.buildNumber); //获取当前的版本号
        if (currentNumber <= minVersion) {
          /// 强制更新
          state(VersionState.Force, versionInfoModel);
        } else if (minVersion < currentNumber && currentNumber < newVersion) {
          /// 选择更新
          state(VersionState.Select, versionInfoModel);
        }
      });
    });
  }
}

enum VersionState {
  Force,
  Select,
}
