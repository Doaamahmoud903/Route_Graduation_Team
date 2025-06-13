import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';
import 'package:movie_app/features/auth/presentation/views/signup_view.dart';
import 'package:movie_app/features/layout/presentation/views/layout_view.dart';
import 'package:movie_app/features/browse/presentation/views/browse_view.dart';
import 'package:movie_app/features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/layout/presentation/manager/layout_cubit.dart';
import '../../l10n/app_localizations.dart';
import '../localization/locale_cubit/locale_cubit.dart';
import '../theming/app_theme.dart';
import '../theming/theme/theme_cubit.dart';

Widget buildAppRoot(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LocaleCubit()),
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => LayoutCubit()),
    ],
    child: Builder(
      builder: (context) {
        final localeState = context.watch<LocaleCubit>().state;
        final themeState = context.watch<ThemeCubit>().state;

        return DevicePreview(
          enabled: false,
          builder: (context) {
            return MaterialApp(
              locale:
                  (localeState is ChangeLocaleState)
                      ? localeState.locale
                      : const Locale('en'),
              supportedLocales: const [Locale("en"), Locale("ar")],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              darkTheme: darkTheme(),
              themeMode: themeState.themeMode,
              initialRoute:HomeView.routeName,
              // OnboardingView.routeName,
              routes: {
                HomeView.routeName: (context) => const HomeView(),
                LayoutView.routeName: (context) => const LayoutView(),
                OnboardingView.routeName: (context) => const OnboardingView(),
                ForgotPasswordView.routeName:
                    (context) => const ForgotPasswordView(),
                LoginView.routeName: (context) => const LoginView(),
                SignupView.routeName: (context) => const SignupView(),
                BrowseView.routeName: (context) => const BrowseView(),
              },
            );
          },
        );
      },
    ),
  );
}
