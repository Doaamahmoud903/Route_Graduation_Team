import 'package:movie_app/features/account/data/models/ProfileResponse.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfile();
  Future<ProfileResponse> updateProfile({
    required String name,
    required String phone,
    required String email,
    required int avaterId,
  });

  Future<Map<String, dynamic>> deleteProfile();
}