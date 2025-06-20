import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart';
import 'package:movie_app/features/account/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:movie_app/features/account/data/models/ProfileResponse.dart';

import '../../../../../../core/api/api_services.dart';
import '../../../../../../core/cach_helper/cach_helper.dart';


@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;
  final CacheHelper cacheHelper;

  ProfileRemoteDataSourceImpl(
      {required this.apiService, required this.cacheHelper});

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final token = await cacheHelper.getData("token");
      debugPrint(
          'ProfileRemoteDataSourceImpl: Attempting to fetch profile with token: ${token !=
              null ? "exists" : "null"}');

      if (token == null || token.isEmpty) {
        await cacheHelper.removeData("token");
        throw Exception(
            'Authentication token not found or invalid. Please log in.');
      }

      final response = await apiService.get(
        baseUrl: ApiConstant.baseUrlPostman,
        endPoint: ApiConstant.profile,
        token: token,
      );

      debugPrint(
          'ProfileRemoteDataSourceImpl: Get profile API response: $response');

      if (response['message'] == "Profile fetched successfully" &&
          response['data'] != null) {
        return ProfileResponse.fromJson(response);
      } else {
        final errorMessage = response['message'] ??
            'Failed to fetch profile data with unexpected response.';
        debugPrint(
            'ProfileRemoteDataSourceImpl: Unexpected profile API response: $errorMessage');
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      debugPrint('ProfileRemoteDataSourceImpl: Error fetching profile: $e');
      if (e.toString().contains('token') ||
          e.toString().contains('unauthorized') ||
          e.toString().contains('expired')) {
        debugPrint(
            'ProfileRemoteDataSourceImpl: Error suggests token issue. Deleting token.');
        await cacheHelper.removeData("token");
      }
      rethrow;
    }
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String name,
    required String phone,
    required String email,
    required int avaterId,
  }) async {
    try {
      final token = await cacheHelper.getData("token");
      debugPrint(
          'ProfileRemoteDataSourceImpl: Attempting to update profile with token: ${token !=
              null ? "exists" : "null"}');

      if (token == null || token.isEmpty) {
        await cacheHelper.removeData("token");
        throw Exception(
            'Authentication token not found or invalid. Please log in to update.');
      }

      final response = await apiService.patch(
        baseUrl: ApiConstant.baseUrlPostman,
        endPoint: ApiConstant.profile,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'avaterId': avaterId
        },
        token: token,
      );

      debugPrint(
          'ProfileRemoteDataSourceImpl: Update profile API response: $response');

      if (response['status'] == true) {
        return ProfileResponse.fromJson(response);
      } else {
        final errorMessage = response['message'] ?? 'Failed to update profile.';
        debugPrint(
            'ProfileRemoteDataSourceImpl: API returned status false on update: $errorMessage');
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      debugPrint('ProfileRemoteDataSourceImpl: Error updating profile: $e');
      if (e.toString().contains('token') ||
          e.toString().contains('unauthorized') ||
          e.toString().contains('expired')) {
        await cacheHelper.removeData("token");
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteProfile() async {
    try {
      final token = await cacheHelper.getData("token");
      debugPrint(
          'ProfileRemoteDataSourceImpl: Attempting to delete profile with token: ${token !=
              null ? "exists" : "null"}');

      if (token == null || token.isEmpty) {
        await cacheHelper.removeData("token");
        throw Exception(
            'Authentication token not found or invalid. Please log in to delete profile.');
      }

      final response = await apiService.delete(
        baseUrl: ApiConstant.baseUrlPostman,
        endPoint: ApiConstant.profile,
        token: token,
      );

      debugPrint(
          'ProfileRemoteDataSourceImpl: Delete profile API response: $response');

      if (response['status'] == true) {
        return response;
      } else {
        final errorMessage = response['message'] ?? 'Failed to delete profile.';
        debugPrint(
            'ProfileRemoteDataSourceImpl: API returned status false on delete: $errorMessage');
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      debugPrint('ProfileRemoteDataSourceImpl: Error deleting profile: $e');
      if (e.toString().contains('token') ||
          e.toString().contains('unauthorized') ||
          e.toString().contains('expired')) {
        await cacheHelper.removeData("token");
      }
      rethrow;
    }
  }
}
