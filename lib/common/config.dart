import 'package:flutter_project1/util/log_util.dart';

/// 公共App配置
/// 初始化后，通过[Config.inst]获取实例
class Config {
  static final Config inst = Config._();

  /// 是否是debug模式
  bool debug;

  /// 本地存储数据库名称
  String dbName;

  /// 后端API服务地址前缀
  String apiUrl;

  /// 日志级别
  LogLevel logLevel;

  Config._();

  factory Config.fill({
    bool debug,
    String dbName,
    String apiUrl,
    LogLevel logLevel,
  }) {
    inst.debug = debug ?? true;
    inst.dbName = dbName ?? "db_name";
    inst.apiUrl = apiUrl;
    inst.logLevel = logLevel ?? LogLevel.info;
    // 重设日志级别
    Log.setLevel(inst.logLevel);
    return inst;
  }
}
