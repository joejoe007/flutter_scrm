import 'package:flutter_project1/util/sp_util.dart';

import 'const.dart';

class JSCodeUtil {
  /// 传递token
  static final String  jsSendToken  = "window.localStorage.setItem('catchDataForApp',JSON.stringify({data:{token:'${SpUtil.getString(Constant.Token_key)}'}}));";


}
