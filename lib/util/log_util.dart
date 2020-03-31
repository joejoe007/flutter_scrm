import 'package:logger/logger.dart';

enum LogLevel {
  debug,
  info,
  warn,
  error,
}

/// 日志包装类
class Log {
  Log._();

  static Logger _logger = Logger();

  static Level _convertLevel(LogLevel orig) {
    switch (orig) {
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warn:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      default:
        return Level.info;
    }
  }

  static setLevel(LogLevel level) {
    Logger.level = _convertLevel(level);
  }

  static debug(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static info(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static warn(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static error(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
