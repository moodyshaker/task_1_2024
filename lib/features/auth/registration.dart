import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../constants.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/router/router.dart';
import '../../core/validate/validation.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/main_text.dart';
import '../home/home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.get(context);
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.h,
            child: FadeInAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.h.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(
                        text: 'Sign Up',
                        font: 24.sp,
                        color: Colors.black,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  40.h.hSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: auth.regUsernameController,
                              prefix: 'username_icon',
                              hint: 'Username',
                              type: TextInputType.text,
                              valid: (String? v) => v!.isEmpty
                                  ? 'Please Enter Your User Name'
                                  : null,
                            ),
                            20.h.hSpace,
                            CustomTextField(
                              controller: auth.regEmailController,
                              hint: 'Enter Email Address',
                              prefix: 'email_icon',
                              type: TextInputType.emailAddress,
                              valid: (String? v) =>
                                  !Validations.validateUserEmail(v!)
                                      ? 'Please Check Your Email Address'
                                      : null,
                            ),
                            20.h.hSpace,
                            CustomTextField(
                              controller: auth.regPasswordController,
                              hint: 'Enter Password',
                              prefix: 'password_icon',
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                              valid: (String? v) => v!.isEmpty
                                  ? 'Please Enter your password'
                                  : v.length < 8
                                      ? 'Make sure your password is not less than 8 characters'
                                      : null,
                            ),
                            20.h.hSpace,
                            CustomTextField(
                              controller: auth.regConfirmPasswordController,
                              hint: 'Confirm Password',
                              prefix: 'password_icon',
                              type: TextInputType.visiblePassword,
                              isPassword: true,
                              valid: (String? v) => v!.isEmpty
                                  ? 'Please Enter your password'
                                  : v.length < 8
                                      ? 'Make sure your password is not less than 8 characters'
                                      : v != auth.regPasswordController.text
                                          ? 'Please Check your password'
                                          : null,
                            ),
                            20.h.hSpace,
                            CustomButton(
                              title: 'Sign Up',
                              onPressed: () async {
                                if (_form.currentState!.validate()) {
                                  await auth.registration();
                                }
                              },
                            ),
                            40.h.hSpace,
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
                                    MagicRouter.navigateAndPopAll(Login());
                                  },
                                  child: MainText(
                                    text: ' Sign In',
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
