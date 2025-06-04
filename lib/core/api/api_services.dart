import 'package:dio/dio.dart';
import 'package:movie_app/core/api/api_constant.dart';
import '../localization/langauge_cache_helper/language_cache_helper.dart';

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
      return Options(headers: {'token': token});
    }
    return Options();
  }

  // GET
  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // POST
  Future<Map<String, dynamic>> post({
    required String endPoint,
    required dynamic data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  //Upload File

  Future<Map<String, dynamic>> uploadFile({
    required String endPoint,
    required FormData data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // DELETE
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  // PUT
  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    var options = _getOptionsWithToken(token);
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
