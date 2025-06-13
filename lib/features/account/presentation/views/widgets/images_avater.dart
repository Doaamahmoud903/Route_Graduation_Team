import 'package:movie_app/core/utils/assets_manager.dart';
class Images{
  static const String defaultAvatar = AssetManager.profile1;
  static const List<String> avatars = [
    '',
    AssetManager.profile1,
    AssetManager.profile2,
    AssetManager.profile3,
    AssetManager.profile4,
    AssetManager.profile5,
    AssetManager.profile6,
    AssetManager.profile7,
    AssetManager.profile8,
    AssetManager.profile9,
  ];

  static String getAvatarPath(int avatarId) {
    if (avatarId > 0 && avatarId < avatars.length) {
      return avatars[avatarId];
    }
    return defaultAvatar; // Fallback for invalid or 0 ID
  }
}