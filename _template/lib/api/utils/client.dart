import 'package:dio/dio.dart';
import 'package:gnc_dao_envisagerapp/api/api.dart';

class Client {
  final Dio _dio;
  static final Client _instance = Client._();
  static Dio get instance => _instance._dio;

  static void setLogoutCallback(void Function() onLogout) {
    _instance._dio.interceptors.add(AuthInterceptor(onLogout));
  }

  Client._()
      : _dio = Dio(BaseOptions(
          baseUrl: envisagerApiUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        )) {
    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        error: true,
      ),
      InterceptorsWrapper(
        onError: (error, handler) => handler.next(_handleDioError(error)),
      ),
    ]);
  }
}

DioException _handleDioError(DioException error) {
  // 기본 메시지
  String customMessage = "An unknown error occurred";

  if (error.response != null) {
    // 서버 응답이 있을 때 상태 코드별 메시지 처리
    switch (error.response?.statusCode) {
      case 400:
        customMessage = "Bad request. Please try again.";
        break;
      case 401:
        customMessage = "Unauthorized. Please check your credentials.";
        break;
      case 403:
        customMessage = "Forbidden. You don't have permission to access this.";
        break;
      case 404:
        customMessage = "Not found. The resource does not exist.";
        break;
      case 500:
        customMessage = "Server connect fail. Please try again later.";
        break;
      default:
        customMessage = "Received invalid status code: ${error.response?.statusCode}";
        break;
    }
  } else if (error.type == DioExceptionType.connectionTimeout) {
    customMessage = "Connection timeout. Please check your network.";
  } else if (error.type == DioExceptionType.receiveTimeout) {
    customMessage = "Receive timeout. The server took too long to respond.";
  } else if (error.type == DioExceptionType.cancel) {
    customMessage = "Request was cancelled.";
  } else if (error.type == DioExceptionType.unknown) {
    customMessage = "An unknown error occurred. Please try again.";
  }

  // 수정된 DioException 생성
  return DioException(
    requestOptions: error.requestOptions,
    response: error.response,
    type: error.type,
    error: customMessage,
  );
}
