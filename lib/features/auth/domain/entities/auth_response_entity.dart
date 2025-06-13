import 'package:json_annotation/json_annotation.dart';

class UserResponseEntity {
  final String? message;
  final String? data;
  final int? statusCode;
  final String? error;

  UserResponseEntity({this.error, this.message, this.data, this.statusCode});
}




