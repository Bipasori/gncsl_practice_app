import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.onLogout);
  void Function() onLogout;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403) onLogout.call();
    super.onError(err, handler);
  }
}
