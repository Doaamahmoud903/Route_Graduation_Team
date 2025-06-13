import 'package:injectable/injectable.dart';
import 'package:movie_app/features/account/data/data_sources/profile_remote_data_source.dart';
import 'package:movie_app/features/account/data/models/ProfileResponse.dart';
import 'package:movie_app/features/account/data/repository/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileResponse> getProfile() async {
    return remoteDataSource.getProfile();
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String name,
    required String email,
    required String phone,
    required int avaterId
  }) async {
    return remoteDataSource.updateProfile(
        name: name,
        phone: phone,
        email: email,
        avaterId: avaterId);
  }

  @override
  Future<Map<String, dynamic>> deleteProfile() {
    return
      remoteDataSource.deleteProfile();
  }
}