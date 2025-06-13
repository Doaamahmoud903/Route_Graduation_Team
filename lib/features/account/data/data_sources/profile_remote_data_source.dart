import 'package:movie_app/features/account/data/models/ProfileResponse.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfile();//String? token
  Future<ProfileResponse> updateProfile({
    required String name,
    required String phone,
    required String email,
    required int avaterId,});//Data profileData, String? token
  Future<Map<String, dynamic>> deleteProfile();//String? token
}