import 'package:flutter/material.dart';
import 'package:movie_app/features/layout/presentation/views/widgets/layout_view_body.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "LayoutView";
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return  LayoutViewBody();
  }
}
