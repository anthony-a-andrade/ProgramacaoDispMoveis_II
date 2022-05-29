import 'dart:developer';

class Logger {
  static void info(String msg) => log(msg, name: "info");
  static void error(String msg, [Object? obj]) => log(msg, name: "error", error: obj);
}