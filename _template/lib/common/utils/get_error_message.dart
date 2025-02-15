import 'dart:developer';

import 'package:dio/dio.dart';

String getErrorMessage(dynamic e) {
  log("====================== Error ======================");
  log(e is DioException ? e.message ?? e.toString() : e.toString());
  // log(e is MessageException ? e.message ?? "" : e.toString());
  log("---------------------------------------------------");

  if (e is DioException && e.error is String) return e.error as String;
  // if (e is MessageException && e.message != null) return e.message!;

  return "Error!";
}
