import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';

import 'images_avater.dart';

class PickAvatarWidget extends StatefulWidget {
  final int currentSelectedAvatarId;
  const PickAvatarWidget({super.key, required this.currentSelectedAvatarId}); // Added const

  @override
  State<PickAvatarWidget> createState() => _PickAvatarWidgetState();
}

class _PickAvatarWidgetState extends State<PickAvatarWidget> {
  int? selectedAvatarId;

  @override
  void initState() {
    super.initState();
    // Initialize selectedAvatarId with the current selected avatar from the parent,
    // ensuring it falls within the valid range of avatar IDs.
    if (widget.currentSelectedAvatarId >= 0 &&
        widget.currentSelectedAvatarId < Images.avatars.length) {
      selectedAvatarId = widget.currentSelectedAvatarId;
    } else {
      // Default to 0 (first avatar) if the provided ID is out of range.
      selectedAvatarId = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: const EdgeInsets.all(5), // Use EdgeInsets.all
      margin: const EdgeInsets.all(16), // Use EdgeInsets.all
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: ColorManager.grey
      ) ,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16), // Use EdgeInsets.all
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: Images.avatars.length, // Corrected itemCount to use actual list length
        itemBuilder: (context, index) {
          final int currentAvatarIndex = index; // Avatar IDs are 0-indexed based on list index
          final bool isSelected = selectedAvatarId == currentAvatarIndex;
          final String avatarPath = Images.getAvatarPath(currentAvatarIndex);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAvatarId = currentAvatarIndex; // Update the selected ID
              });
              Navigator.pop(context, selectedAvatarId); // Return the selected avatar ID
            },
            child: Container(
              padding: const EdgeInsets.all(10), // Use EdgeInsets.all
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)), // Use BorderRadius.all
                border: Border.all(
                    width: 1.w,
                    color: ColorManager.orangeColor
                ),
                color: isSelected ? ColorManager.orangeAvatarColor : ColorManager.transparentColor,
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

























/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';

import 'images.dart';

class PickAvatarWidget extends StatefulWidget {
  final int currentSelectedAvatarId;
   PickAvatarWidget({super.key, required this.currentSelectedAvatarId});
  @override
  State<PickAvatarWidget> createState() => _PickAvatarWidgetState();
}
class _PickAvatarWidgetState extends State<PickAvatarWidget> {
  int? selectedAvatarId;
  late int numberOfAvatars;

  @override
  void initState() {
    super.initState();
    int numberOfAvatars = Images.avatars.length - 1; // Assuming IDs are 1-based

    // Initialize selectedAvatarId if a valid initial ID is provided
    if (widget.currentSelectedAvatarId >= 0 &&
        widget.currentSelectedAvatarId < numberOfAvatars) {
      selectedAvatarId = widget.currentSelectedAvatarId;
    } else {
      // Default to 1 if no valid initial ID, or keep null for no selection
      selectedAvatarId = 1; // Or null, depending on desired default behavior
    }
  }

  /*@override
  void initState() {
    super.initState();
    if (widget.initialSelectedAvatar != null) {
      selectedIndex = profileImages.indexOf(widget.initialSelectedAvatar!);
      if (selectedIndex! < 0) { // If initial avatar not found in our list
        selectedIndex = null;
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
     return Container(
       //width: 398.w,
       height: 300.h,
       padding: const EdgeInsetsGeometry.all(5),
       margin: const EdgeInsetsGeometry.all(16),
       decoration:BoxDecoration(
         borderRadius: BorderRadius.circular(24.r),
         color: ColorManager.grey
       ) ,
       child: GridView.builder(
         shrinkWrap: true,
         padding: const EdgeInsetsGeometry.all(16),
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 3,
           crossAxisSpacing: 10.0,
           mainAxisSpacing: 10.0,
           childAspectRatio: 1.0,
         ),
         itemCount: numberOfAvatars,
         itemBuilder: (context, index) {
           final int currentAvatar = index ;
           final bool isSelected = selectedAvatarId == currentAvatar;
           final String avatarPath = Images.getAvatarPath(currentAvatar);
           return GestureDetector(
             onTap: () {
               setState(() {
                 selectedAvatarId = currentAvatar; // Update the selected ID
               });
               Navigator.pop(context, selectedAvatarId); // Return the selected avatar URL
             },
             child: Container(
               padding: const EdgeInsetsGeometry.all(10),
               decoration: BoxDecoration(
                 borderRadius: BorderRadiusGeometry.all(Radius.circular(20.r)),
                 border: Border.all(
                   width: 1.w,
                   color: ColorManager.orangeColor
                 ),
                 color: isSelected ? ColorManager.orangeAvatarColor : ColorManager.transparentColor,
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
*/