import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Features/Auth/Cubit/auth_cubit.dart';
import '../../../../Core/Shared Widgets/snackBar_widget.dart';
import '../../../../routing/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32.h),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  var authCubit = AuthCubit.get(context);
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/loginPage.png',
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        "البريد الإلكتروني",
                        authCubit.loginEmailController,
                      ),
                      const SizedBox(height: 12),
                      _buildInputField(
                        "كلمة المرور",
                        authCubit.loginPasswordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is LoginSuccessState) {
                              context.pushNamed(Routes.layoutScreen.name);
                            }
                            if (state is LoginErrorState) {
                              context.showErrorSnackBar(
                                'Failed to login: ${state.message}',
                              );
                            }
                          },
                          builder: (context, state) {
                            var cubit = AuthCubit.get(context);
                            return state is LoginLoadingState
                                ? Center(
                                  child: CircularProgressIndicator(
                                    color: cPrimaryColor,
                                  ),
                                )
                                : ElevatedButton(
                                  onPressed: () {
                                    if (cubit
                                            .loginEmailController
                                            .text
                                            .isNotEmpty &&
                                        cubit
                                            .loginPasswordController
                                            .text
                                            .isNotEmpty) {
                                      cubit.login(
                                        cubit.loginEmailController.text.trim(),
                                        cubit.loginPasswordController.text
                                            .trim(),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: cPrimaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("تسجيل الدخول"),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "هل نسيت كلمة المرور؟",
                            style: TextStyle(color: Colors.black),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton("assets/images/google.png"),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(Routes.registercreen.name);
                        },
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            text: 'ليس لديك حساب؟ ',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'سجل الان',
                                style: TextStyle(
                                  color: cPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String hint,
    TextEditingController controller, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GoogleFirebaseSuccessState) {
          context.pushNamed(Routes.layoutScreen.name);
        }
        if (state is GoogleFirebaseErrorState) {
          context.showErrorSnackBar('Failed to load data: ${state.message}');
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return GestureDetector(
          onTap: () {
            cubit.loginWithGoogle();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 22,
            child: Image.asset(assetPath, height: 22, width: 22),
          ),
        );
      },
    );
  }
}
