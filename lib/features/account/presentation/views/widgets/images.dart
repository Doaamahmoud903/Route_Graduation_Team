import '../../../../../core/utils/assets_manager.dart';

List<Map<String, dynamic>> profileImages = [
  {'path':AssetManager.profile1, 'id': 1},
  {'path':AssetManager.profile2, 'id': 2},
  {'path':AssetManager.profile3, 'id': 3},
  {'path':AssetManager.profile4, 'id': 4},
  {'path':AssetManager.profile5, 'id': 5},
  {'path':AssetManager.profile6, 'id': 6},
  {'path':AssetManager.profile7, 'id': 7},
  {'path':AssetManager.profile8, 'id': 8},
  {'path':AssetManager.profile9, 'id': 9},

];

class Images {
  static const String defaultAvatar = AssetManager.profile1;

  static String getAvatarPath(int avatarId) {
    if (avatarId == 0) {
      return defaultAvatar;
    }
    try {
      final avatarMap = profileImages.firstWhere((element) =>
      element['id'] == avatarId);
      return avatarMap['path'] as String;
    } catch (e) {
      return defaultAvatar;
    }
  }

  static List<Map<String, dynamic>> get allProfileImages => profileImages;
}