import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hostel_hive/core/app_export.dart';

enum Method { post, get, put, delete, patch }

class NetworkCall {
  static final NetworkCall _instance = NetworkCall._();
  static bool _isInitialized = false;
  static final Dio _dio = Dio(
    BaseOptions(
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 15),
      baseUrl: ApiEndPoints.baseUrl,
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer ${LocalStorage.userToken}",
      },
    ),
  );

  static const int _maxRetryAttempts = 1;

  factory NetworkCall() {
    if (!_isInitialized) _instance._init();
    return _instance;
  }

  NetworkCall._();

  void _init() {
    String platform = Platform.isAndroid
        ? 'Android'
        : Platform.isIOS
            ? 'iOS'
            : 'Unknown';
    String osVersion = Platform.operatingSystemVersion;
    String operatingSystem = Platform.operatingSystem;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          // Add platform and OS version headers if not already present
          requestOptions.headers.putIfAbsent('X-Platform', () => platform);
          requestOptions.headers.putIfAbsent('X-OS-Version', () => osVersion);
          requestOptions.headers.putIfAbsent(
            'X-Operating-System',
            () => operatingSystem,
          );
          // Always set Authorization header to latest token if available
          if (requestOptions.headers['Authorization'] == null) {
            if (LocalStorage.userToken != null) {
              requestOptions.headers['Authorization'] =
                  'Bearer ${LocalStorage.userToken}';
            }
          }

          logger.i(
            "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
            "=> REQUEST QUERY: ${requestOptions.queryParameters} => REQUEST PARAMS: ${requestOptions.data} => HEADERS: ${requestOptions.headers}",
          );
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          logger.i(
            "RESPONSE[${response.statusCode}] => DATA: ${response.data}",
          );

          return handler.next(response);
        },
        onError: (DioException exception, handler) async {
          // Retry logic for timeouts
          if (_shouldRetry(exception)) {
            await _retryRequest(exception, handler);
          } else {
            _handleException(exception);

            return handler.next(exception);
          }
        },
      ),
    );
    _isInitialized = true;
  }

  bool _shouldRetry(DioException exception) {
    return exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout;
  }

  Future<void> _retryRequest(
    DioException exception,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = exception.requestOptions;
    int retryCount = requestOptions.extra['retryCount'] ?? 0;
    int maxRetryAttempts =
        requestOptions.extra['maxRetryAttempts'] ?? _maxRetryAttempts;

    if (retryCount < maxRetryAttempts) {
      requestOptions.extra['retryCount'] = retryCount + 1;
      try {
        final response = await _dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // If still fails, pass the error to next
        return handler.reject(e as DioException);
      }
    } else {
      // Show timeout snackbar after max retries
      _showToast("Request timed out. Please try again.");
      return handler.next(exception);
    }
  }

  /// Makes a network request with the given parameters.
  /// [url]: The endpoint URL (relative to baseUrl).
  /// [method]: The HTTP method to use.
  /// [params]: The request body (for POST/PUT/PATCH).
  /// [queryParameters]: The query parameters for the request.
  /// [token]: Optional bearer token to override the default.
  /// [baseurl]: Optional base URL to override the default.
  /// [retryCount]: Number of retry attempts for this request (default: _maxRetryAttempts).
  Future<dynamic> makeRequest({
    required String url,
    required Method method,
    Object? params,
    Map<String, dynamic>? queryParameters,
    String? token,
    String? baseurl,
    int retryCount = _maxRetryAttempts,
  }) async {
    Response response;
    // Set Authorization header if token is provided for this request
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    } else if (LocalStorage.userToken != null) {
      // Though the LocalStorage.userToken is set,
      // during the instance creation, we need to set this token again
      // because the NetworkCall instance is a singleton instance,
      // thus it is not able to set the user token after the login is done
      //
      // this makes setting the token during instantiation redundant
      _dio.options.headers["Authorization"] =
          "Bearer ${LocalStorage.userToken}";
    } else {
      _dio.options.headers.remove("Authorization");
    }
    if (baseurl != null) {
      _dio.options.baseUrl = baseurl;
    } else {
      _dio.options.baseUrl = ApiEndPoints.baseUrl;
    }

    try {
      final options = Options(
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        extra: {'maxRetryAttempts': retryCount},
      );
      if (method == Method.post) {
        response = await _dio.post(
          url,
          data: params,
          queryParameters: queryParameters,
          options: options,
        );
      } else if (method == Method.delete) {
        response = await _dio.delete(url, options: options);
      } else if (method == Method.patch) {
        response = await _dio.patch(url, options: options);
      } else {
        response = await _dio.get(
          url,
          queryParameters: queryParameters,
          options: options,
        );
      }

      if (response.statusCode == 200) {
        return response;
      } else {
        // For all other status codes, throw to let the interceptor handle
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'HTTP error: ${response.statusCode}',
        );
      }
    } on SocketException catch (e) {
      logger.e(e);
      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioException catch (e) {
      logger.e(e);
      // No manual retry here, handled by interceptor
      rethrow;
    } catch (e) {
      logger.e(e);
      throw Exception("Something went wrong");
    }
  }

  void _handleException(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout) {
      _showToast("Request timed out. Please try again.");
    } else if (exception.response != null) {
      switch (exception.response?.statusCode) {
        case 400:
          logger.e('Bad request: ${exception.response?.data}');
          break;
        case 401:
          logger.e('Unauthorized: ${exception.response?.data}');
          break;
        case 403:
          logger.e('Forbidden: ${exception.response?.data}');
          break;
        case 404:
          logger.e('Not found: ${exception.response?.data}');
          break;
        case 500:
          logger.e('Internal server error');
          break;
        default:
          logger.e('Invalid status code: ${exception.response?.statusCode}');
      }
    } else {
      logger.e('Unexpected error: ${exception.message}');
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
