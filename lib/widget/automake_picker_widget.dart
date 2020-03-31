import 'package:flutter/cupertino.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_project1/common/app_color.dart';

class ShowPickerWidget{
  static void showPicker(BuildContext context, List pickerArr, PickerConfirmCallback callback){
    Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: pickerArr,
          isArray: false,
        ),
        changeToFirst: true,
        hideHeader: false,
        cancelText: '取消',
        confirmText: '确定',
        confirmTextStyle: TextStyle(
            color: AppColors.color_maincolor,
            fontSize: 20,
            fontWeight: FontWeight.normal),
        onConfirm: callback)
        .showModal(context);
  }
}