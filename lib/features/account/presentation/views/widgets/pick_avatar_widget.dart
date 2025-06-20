import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';

import 'images.dart';

class PickAvatarWidget extends StatefulWidget {
  final int currentSelectedAvatarId;

  const PickAvatarWidget({super.key, required this.currentSelectedAvatarId});

  @override
  State<PickAvatarWidget> createState() => _PickAvatarWidgetState();
}

class _PickAvatarWidgetState extends State<PickAvatarWidget> {
  int? selectedAvatarId;

  @override
  void initState() {
    super.initState();
    selectedAvatarId = widget.currentSelectedAvatarId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: ColorManager.grey
      ),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: Images.allProfileImages.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> avatarData = Images
              .allProfileImages[index];
          final int avatarId = avatarData['id'] as int;
          final String avatarPath = avatarData['path'] as String;

          final bool isSelected = selectedAvatarId == avatarId;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatarId = avatarId;
              });
              Navigator.pop(context, selectedAvatarId);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                border: Border.all(
                    width: 1.w,
                    color: ColorManager.orangeColor
                ),
                color: isSelected
                    ? ColorManager.orangeAvatarColor
                    : ColorManager.transparentColor,
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundImage: AssetImage(avatarPath),
                backgroundColor: ColorManager.transparentColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
