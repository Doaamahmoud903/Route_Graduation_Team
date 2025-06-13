import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import '../localization/langauge_cache_helper/language_cache_helper.dart';
// import 'api_constant.dart';

@injectable
class ApiService {
  static const String _baseUrl = ApiConstant.baseUrl;
  final Dio _dio;
  static String _currentLanguage = 'en';

  ApiService(this._dio) {
    _initializeLanguage();
  }

  void _initializeLanguage() async {
    _currentLanguage = await LanguageCacheHelper().getCachedLanguageCode();
  }

  static void setLanguage(String language) {
    _currentLanguage = language;
  }

  // Helper method to add token to the headers if provided
  Options _getOptionsWithToken([String? token]) {
    if (token != null) {
      return Options(headers: {
        "Authorization": "Bearer $token", // Add Bearer Token
        "Content-Type": "application/json",
      },);
    }
    return Options();
  }

  // GET
  Future<Map<String, dynamic>> get({
    String? baseUrl,
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var url = '${baseUrl ?? ApiConstant.baseUrl}$endPoint';
    var response = await _dio.get(
      url,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // POST
  Future<Map<String, dynamic>> post({
    String? baseUrl,
    required String endPoint,
    required dynamic data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var url = '${baseUrl ?? ApiConstant.baseUrl}$endPoint';
    var response = await _dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  //Upload File

  Future<Map<String, dynamic>> uploadFile({
    String? baseUrl,
    required String endPoint,
    required FormData data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var url = '${baseUrl ?? ApiConstant.baseUrl}$endPoint';
    var response = await _dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // DELETE
  Future<Map<String, dynamic>> delete({
    String? baseUrl,
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var url = '${baseUrl ?? ApiConstant.baseUrl}$endPoint';
    var response = await _dio.delete(
      url,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // PUT
  Future<Map<String, dynamic>> put({
    String? baseUrl,
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var url = '${baseUrl ?? ApiConstant.baseUrl}$endPoint';
    var response = await _dio.put(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
