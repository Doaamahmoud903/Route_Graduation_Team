import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'package:movie_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:movie_app/l10n/app_localizations.dart';

class WelcomeSplash extends StatefulWidget {
  final OnboardingModel item;
  final VoidCallback onStart;
  const WelcomeSplash({super.key, required this.onStart, required this.item});
  @override
  State<WelcomeSplash> createState() => _WelcomeSplashState();
}

class _WelcomeSplashState extends State<WelcomeSplash> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(widget.item.image),
        Positioned(
          bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width*0.01,
                vertical: height*0.01
              ),
              color: ColorManager.blackColor.withOpacity(0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.item.titleEn ,
                    textAlign: TextAlign.center,
                    style:const TextStyle(
                      fontSize: 36
                    ),),
                  SizedBox(height: height*0.01,),
                  Text(widget.item.descEn,
                    textAlign: TextAlign.center,
                    style:const TextStyle(
                        fontSize: 20
                    ),),
                  SizedBox(height: height*0.02,),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width*0.02,
                        vertical: height*0.01
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: height*0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.orangeColor,
                            foregroundColor: ColorManager.blackColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                          ),
                          onPressed: () {
                            setState(() {
                              widget.onStart();
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.explore,
                            style: Styles.textStyle20w7,
                          )),
                    ),
                  )
                ],
              ),
        ))

      ],
    );
  }
}
