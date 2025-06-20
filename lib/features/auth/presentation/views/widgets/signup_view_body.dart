import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/core/utils/validators.dart';
import 'package:movie_app/core/widgets/custom_loding_indicator.dart';
import 'package:movie_app/features/auth/presentation/manager/signup/signup_states.dart';
import 'package:movie_app/features/auth/presentation/manager/signup/signup_view_model.dart';
import 'package:movie_app/features/auth/presentation/views/login_view.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import '../../../../../core/localization/locale_cubit/locale_cubit.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/theming/color_manager.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../account/presentation/views/widgets/images.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});
  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  SignupViewModel signupViewModel = getIt<SignupViewModel>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: signupViewModel,
      listener: (context , state){
        if(state is SignupLoadingState){
          const Center(child: CustomLoadingIndicator(),);
        }else if(state is SignupFailureState){
          ToastUtils.showErrorToast(state.errorMsg.first);
        }else if(state is SignupSuccessState){
          ToastUtils.showSuccessToast(AppLocalizations.of(context)!.register_success);
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(AppLocalizations.of(context)!.register,
            style: const TextStyle(
              color: ColorManager.orangeColor,
              fontSize: 20,
            ) ,),
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Bootstrap.arrow_left,color: ColorManager.orangeColor,)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signupViewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 120.0,
                    autoPlay: false,
                    viewportFraction: 0.35,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    scrollPhysics: const BouncingScrollPhysics(),
                    aspectRatio: 3.0,
                  ),
                  items: profileImages.map((item) {
                    return GestureDetector(
                      onTap: () {
                        signupViewModel.updateAvatarId(item['id']);
                        print('Avatar ID: ${signupViewModel.avatarId}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(item['path']),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: height*0.02,),
                CustomTextField(
                  controller: signupViewModel.nameController,
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: AssetManager.username,
                  fillColor: const Color(0xFF1E1E1E),
                  hintColor: Colors.white,
                  prefixColor: Colors.white,
                  borderColor: Colors.transparent,
                  validator: Validators.validateName,

                ),
                SizedBox(height: height*0.02,),
                CustomTextField(
                  controller: signupViewModel.emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: AssetManager.email,
                  fillColor: const Color(0xFF1E1E1E),
                  hintColor: Colors.white,
                  prefixColor: Colors.white,
                  borderColor: Colors.transparent,
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: height*0.02,),

                CustomTextField(
                  controller: signupViewModel.passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: AssetManager.lock,
                  fillColor: const Color(0xFF1E1E1E),
                  hintColor: Colors.white,
                  prefixColor: Colors.white,
                  borderColor: Colors.transparent,
                  isPassword: true,
                  suffixColor: Colors.white,
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: height*0.02,),

                CustomTextField(
                  controller: signupViewModel.rePasswordController,
                  hintText:AppLocalizations.of(context)!.re_password,
                  prefixIcon: AssetManager.lock,
                  fillColor: const Color(0xFF1E1E1E),
                  hintColor: Colors.white,
                  prefixColor: Colors.white,
                  borderColor: Colors.transparent,
                  isPassword: true,
                  suffixColor: Colors.white,
                  validator: (value) => Validators.validateConfirmPassword(value, signupViewModel.passwordController.text),
                ),
                SizedBox(height: height*0.02,),

                CustomTextField(
                  controller: signupViewModel.phoneController,
                  hintText: AppLocalizations.of(context)!.phone,
                  prefixIcon: AssetManager.phone,
                  fillColor: const Color(0xFF1E1E1E),
                  hintColor: Colors.white,
                  prefixColor: Colors.white,
                  borderColor: Colors.transparent,
                  //validator: Validators.validatePhone,
                ),

                SizedBox(height: height*0.02,),
                CustomButton(
                    btnName: AppLocalizations.of(context)!.create_account,
                    bgColor: ColorManager.orangeColor,
                    fgColor: Colors.black,
                    textColor: ColorManager.grey,
                    onPressed: signupViewModel.signUp
                ),
                SizedBox(height: height*0.01,),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginView.routeName);
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.have_account_ques,
                          style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),

                        ),
                        Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            color: ColorManager.orangeColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
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
    );
  }
}
