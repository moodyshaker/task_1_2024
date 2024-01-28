import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task/features/auth/registration.dart';
import '../../constants.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/router/router.dart';
import '../../core/validate/validation.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/main_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.get(context);
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.h,
            child: FadeInAnimation(
              child: Column(
                children: [
                  60.h.hSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(
                        text: 'Sign In',
                        font: 24.sp,
                        color: kBlackColor,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  80.h.hSpace,
                  Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: auth.loginEmailController,
                            prefix: 'email_icon',
                            hint: 'Email',
                            type: TextInputType.emailAddress,
                            valid: (String? v) =>
                                !Validations.validateUserEmail(v!)
                                    ? 'Please Check Your Email Address'
                                    : null,
                          ),
                          20.h.hSpace,
                          CustomTextField(
                            controller: auth.loginPasswordController,
                            hint: 'Password',
                            prefix: 'password_icon',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            valid: (String? v) => v!.isEmpty
                                ? 'Please Enter your password'
                                : v.length < 8
                                    ? 'Make sure your password is not less than 8 characters'
                                    : null,
                          ),
                          25.h.hSpace,
                          CustomButton(
                            title: 'Sign In',
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                await auth.login();
                              }
                            },
                          ),
                          50.h.hSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainText(
                                text: 'Dont have an account' + '?',
                                font: 17.sp,
                                color: kBlackColor,
                                weight: FontWeight.w400,
                              ),
                              GestureDetector(
                                onTap: () {
                                  MagicRouter.navigateAndPopAll(Register());
                                },
                                child: MainText(
                                  text: ' Sign Up',
                                  font: 17.sp,
                                  color: kMainColor,
                                  weight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
