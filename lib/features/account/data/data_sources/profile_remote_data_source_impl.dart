import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api/api_constant.dart'; // Unused import
import 'package:movie_app/core/api/api_services.dart';
import 'package:movie_app/features/account/data/data_sources/profile_remote_data_source.dart';
import 'package:movie_app/features/account/data/models/ProfileResponse.dart';
import '../../../../core/services/secure_storage.dart';
import 'package:flutter/material.dart';


@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  final ApiService apiService;
  final SecureStorage secureStorage;
  ProfileRemoteDataSourceImpl({required this.apiService, required this.secureStorage});

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      final token = await secureStorage.getToken();
      debugPrint('ProfileRemoteDataSourceImpl: Attempting to fetch profile with token: $token'); // Important debug line

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please log in.');
      }

      final response = await apiService.get(
        endPoint: ApiConstant.userProfileEndPoint,
        token: token, // Pass the token here
      );

      if (response['status'] == true) {
        return ProfileResponse.fromJson(response);
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch profile data.');
      }
    } catch (e) {
      debugPrint('ProfileRemoteDataSourceImpl: Error fetching profile: $e'); // Log the error
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
      final token = await secureStorage.getToken();
      final response = await apiService.patch(
        endPoint: ApiConstant.updateUserProfileEndPoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'avaterId': avaterId
        },
        token: token,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return ProfileResponse.fromJson(response['data']);
      } else {
        throw Exception(response['message'] ?? 'Failed to update profile.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteProfile() async {
    try {
      final token = await secureStorage.getToken();
      final response = await apiService.delete(
        endPoint: ApiConstant.deleteUserProfileEndPoint,
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}