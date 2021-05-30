import 'package:common_utils/common_utils.dart';
import 'package:demo2_deer/res/constant.dart';

class Log {
  static const String tag = 'DEER-LOG';

  static void init() {
    // LogUtil 的 init 方法可根据是否是生产环境来配置 true 与 false ，如果是 false ,则不输出日志
    LogUtil.init(isDebug: !Constant.inProduction);
  }

  // LogUtil.e 在所有环境中0打印； LogUtil.v 在debug模式中打印
  static void d(String msg, {String tag = tag}) {
    if (!Constant.inProduction) {
      LogUtil.v(msg, tag: tag);
    }
  }

  static void e(String msg, {String tag = tag}) {
    if (!Constant.inProduction) {
      LogUtil.e(msg, tag: tag);
    }
  }
}
