
import 'package:common_utils/common_utils.dart';

class  DateUtils {

 /// 获取当前月最后一天
  static String getEndMonth() {

    DateTime startDate = DateTime.now();
    //DateTime获取年和月
    var dateTime = new DateTime.fromMillisecondsSinceEpoch(
        startDate.millisecondsSinceEpoch);
    //通过DateTime获取当月的下个月第一天。
    var DateNextMonthDate = new DateTime(dateTime.year, dateTime.month + 1, 1);
    //下一个月的第一天时间戳减去一天的时间戳就是当前月的最后一天的时间戳
    int nextTimeSamp =
        DateNextMonthDate.millisecondsSinceEpoch - 24 * 60 * 60 * 1000;
    //取得了下一个月1号码时间戳
    DateTime lastDayDateTime = new DateTime.fromMillisecondsSinceEpoch(nextTimeSamp);
    String formartResult = DateUtil.getDateStrByDateTime(lastDayDateTime,
        format: DateFormat.YEAR_MONTH_DAY);
    return formartResult;
  }




  /// 获取当前月第一天
  static String getStartMonth(){
    DateTime startDate = DateTime.now();
    var dateTime = new DateTime.fromMillisecondsSinceEpoch(
        startDate.millisecondsSinceEpoch);
    DateTime currentMonthDate = new DateTime(dateTime.year, dateTime.month, 1);
    String formartResult = DateUtil.getDateStrByDateTime(currentMonthDate,
        format: DateFormat.YEAR_MONTH_DAY);
    return formartResult;
  }

}