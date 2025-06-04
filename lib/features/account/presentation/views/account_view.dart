import 'package:flutter/material.dart';
import 'package:movie_app/features/account/presentation/views/widgets/account_view_body.dart';

class AccountView extends StatelessWidget {
  static const String routeName = "HomeView";
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return  AccountViewBody();
  }
}
