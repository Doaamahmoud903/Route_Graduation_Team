import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioFactory {

  @lazySingleton
  Dio dio() {
    final dio = Dio();
    const timeout = Duration(seconds: 30);
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        maxWidth: 50,
      ),
    );

    return dio;
  }
}
