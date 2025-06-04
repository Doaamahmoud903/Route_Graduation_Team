import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/presentation/views/widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String routeName = "ForgotPasswordView";
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForgotPasswordViewBody();
  }
}
