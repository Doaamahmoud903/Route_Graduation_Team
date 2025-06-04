import 'package:flutter/material.dart';
import 'package:movie_app/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  static const String routeName = "OnboardingView";

  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return  OnboardingViewBody();
  }
}
