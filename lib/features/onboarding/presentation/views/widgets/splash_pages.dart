import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/theming/styles_manager.dart';
import '../../../data/models/onboarding_model.dart';
class SplashPages extends StatefulWidget {
  final List<OnboardingModel> items;
  SplashPages({super.key, required this.items});

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _onNextPressed() {
    if (_currentIndex < widget.items.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCirc,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);

    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final page = widget.items[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    page.image,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.03,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorManager.blackColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            page.titleEn,
                            style: Styles.textStyle24w7.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            page.descEn,
                            style: Styles.textStyle14w5.copyWith(
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: height * 0.03),
                          SizedBox(
                            width: double.infinity,
                            height: height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.orangeColor,
                                foregroundColor: ColorManager.blackColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: _onNextPressed,
                              child: Text(
                                _currentIndex == widget.items.length - 1
                                    ? AppLocalizations.of(context)!.get_started
                                    : AppLocalizations.of(context)!.next,
                                style: Styles.textStyle20w7,
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          _currentIndex != 0?
                          SizedBox(
                            width: double.infinity,
                            height: height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: ColorManager.orangeColor,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: ColorManager.orangeColor
                                  )
                                ),
                              ),
                              onPressed: (){
                                _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInBack,
                                );
                              },
                              child: Text(AppLocalizations.of(context)!.back,
                                style: Styles.textStyle20w7,
                              ),
                            ),
                          ):Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
