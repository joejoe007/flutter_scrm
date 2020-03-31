import 'package:quiver/strings.dart';

class StringUtil {
  /// 保留小数字
  static String formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  /// 分隔
  static List<String> getSplitString(String names, String symbol) {
    List<String> list = [];
    if (isEmpty(names)) return list;
    list = names.split(symbol);
    return list;
  }

  /// 判空字符，默认返回''
  static String checkEmpty(dynamic value, [String defaultValue = '']) {
    if (value == null) return defaultValue;
    return isEmpty(value?.toString()) ? defaultValue : value?.toString();
  }

}
