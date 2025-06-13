import 'package:flutter/material.dart';
import 'package:movie_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:movie_app/features/onboarding/presentation/views/widgets/splash_pages.dart';
import 'package:movie_app/features/onboarding/presentation/views/widgets/welcome_splash.dart';

class OnboardingViewBody extends StatefulWidget {

  OnboardingViewBody({super.key});
  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}
class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  bool startedSplash  = false;



  @override
  Widget build(BuildContext context) {
    final allItems = OnboardingModel.onboardingItems;
    final welcomeItem = allItems.first;
    final splashItems = allItems.sublist(1);
    return Scaffold(
      body: !startedSplash
          ? WelcomeSplash(
         onStart: (){
           setState((){
             startedSplash = true;
           });
         },
        item: welcomeItem,
      )
      : SplashPages(
        items: splashItems,
      ),
    );
  }
}
