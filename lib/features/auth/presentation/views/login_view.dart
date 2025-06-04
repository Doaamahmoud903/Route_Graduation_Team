import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "LoginView";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginViewBody();
  }
}
