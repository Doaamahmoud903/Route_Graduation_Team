import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/utils/validators.dart';
import 'package:movie_app/features/auth/presentation/manager/reset_password/reset_password_view_model.dart';

import '../../../../../core/theming/color_manager.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class ForgotPasswordViewBody extends StatelessWidget {
   ForgotPasswordViewBody({super.key});
  ResetPasswordViewModel resetPasswordViewModel = getIt<ResetPasswordViewModel>();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forget Password",
          style: TextStyle(
            color: ColorManager.orangeColor,
            fontSize: 16,
          ) ,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Bootstrap.arrow_left,color: ColorManager.orangeColor,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: resetPasswordViewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetManager.forgetPassword),
              CustomTextField(
                controller: resetPasswordViewModel.emailController,
                hintText: 'Email',
                prefixIcon: AssetManager.email,
                fillColor: const Color(0xFF1E1E1E),
                hintColor: Colors.white,
                prefixColor: Colors.white,
                borderColor: Colors.transparent,
                validator: Validators.validateEmail,
              ),

              SizedBox(height: height*0.02,),
              CustomButton(
                  btnName: "Verify Email",
                  bgColor: ColorManager.orangeColor,
                  fgColor: Colors.black,
                  textColor: ColorManager.grey,
                  onPressed: (){}
              ),

            ],
          ),
        ),
      ),
    );
  }
}
