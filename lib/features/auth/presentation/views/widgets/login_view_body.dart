import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/theming/color_manager.dart';
import 'package:movie_app/core/utils/assets_manager.dart';
import 'package:movie_app/core/widgets/app_logo.dart';
import 'package:movie_app/core/widgets/custom_button.dart';
import 'package:movie_app/core/widgets/custom_text_field.dart';
import 'package:movie_app/features/auth/presentation/manager/login/login_states.dart';
import 'package:movie_app/features/auth/presentation/manager/login/login_view_model.dart';
import 'package:movie_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:movie_app/features/auth/presentation/views/signup_view.dart';
import 'package:movie_app/l10n/app_localizations.dart';

import '../../../../../core/localization/locale_cubit/locale_cubit.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/toast_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_loding_indicator.dart';

class LoginViewBody extends StatefulWidget {
  LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  LoginViewModel loginViewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener(
      bloc: loginViewModel,
      listener: (context , state){
        if(state is LoginLoadingState){
          const Center(child: CustomLoadingIndicator(),);
        }else if(state is LoginFailureState){
          ToastUtils.showErrorToast(state.errorMsg);
        }else if(state is LoginSuccessState){
          ToastUtils.showSuccessToast(AppLocalizations.of(context)!.login);
          Navigator.of(context).pushNamed(AppRoutes.layoutRoute);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppLogo(),
          toolbarHeight: height*.2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: loginViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller:loginViewModel.emailController,
                    hintText: AppLocalizations.of(context)!.email,
                    prefixIcon: AssetManager.email,
                    fillColor: const Color(0xFF1E1E1E),
                    hintColor: Colors.white,
                    prefixColor: Colors.white,
                    borderColor: Colors.transparent,
                    typingColor: Colors.white,
                    validator: Validators.validateEmail,

                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller:loginViewModel.passwordController,
                    hintText: AppLocalizations.of(context)!.password,
                    isPassword: true,
                    prefixIcon: AssetManager.lock,
                    fillColor: const Color(0xFF1E1E1E),
                    hintColor: Colors.white,
                    prefixColor: Colors.white,
                    suffixColor: Colors.white,
                    borderColor: Colors.transparent,
                    typingColor: Colors.white,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                       Navigator.pushNamed(context, ForgotPasswordView.routeName);
                      },
                      child:  Text(
                        AppLocalizations.of(context)!.forget_password_ques,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  CustomButton(
                      btnName: AppLocalizations.of(context)!.login,
                      bgColor: ColorManager.orangeColor,
                      fgColor: Colors.black,
                      textColor: ColorManager.grey,
                      onPressed: loginViewModel.login
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupView.routeName);
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.have_account_ques
                            ,style:const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),

                          ),
                          Text(
                            AppLocalizations.of(context)!.create_account,
                            style: const TextStyle(
                              color: ColorManager.orangeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ),
                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                       Expanded(child: Divider(indent: width *0.12,color: ColorManager.orangeColor,)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                        ),
                        child: Text(AppLocalizations.of(context)!.or,
                        style:  const TextStyle(
                          color: ColorManager.orangeColor,
                          fontSize: 15
                        ),),
                      ),
                       Expanded(child: Divider(endIndent: width *0.12,color: ColorManager.orangeColor,)),
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  CustomButton(
                    logo: AssetManager.google,
                      btnName: AppLocalizations.of(context)!.login_with_google,
                      bgColor: ColorManager.orangeColor,
                      fgColor: Colors.black,
                      textColor: ColorManager.grey,
                      onPressed: (){
                      loginViewModel.signInWithGoogle(context);
                      }
                  ),
                  SizedBox(height: height*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final localeCubit = context.read<LocaleCubit>();
                          if (localeCubit.currentLanguageCode == "en") {
                            localeCubit.changeLanguage("ar");
                          } else {
                            localeCubit.changeLanguage("en");
                          }
                        },
                        child: Image.asset(
                          AssetManager.languageSwitch,
                          width: 74,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
