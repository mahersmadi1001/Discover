import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/core/Widgets/Loginwith.dart';
import 'package:Discover/core/Widgets/tfflogin.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';
import 'package:Discover/models/Loginmodel.dart';
import 'package:Discover/view/signup/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool visibilityPassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Form(
          key: loginkey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: 40.h),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30.sp,
                    color: const Color(0xff111111),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Sign in to continue discovering",
                  style: TextStyle(
                    color: const Color(0xff757575),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 36.h),
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff222222),
                  ),
                ),
                SizedBox(height: 8.h),
                TFFLogin(
                  controller: email,
                  hint: "Enter your email address",
                  lapel: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 20.h),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff222222),
                  ),
                ),
                SizedBox(height: 8.h),
                TFFLogin(
                  controller: password,
                  iconscure: IconButton(
                    onPressed: () {
                      setState(() {
                        visibilityPassword = !visibilityPassword;
                      });
                    },
                    icon: Icon(
                      visibilityPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xff757575),
                      size: 20.sp,
                    ),
                  ),
                  hint: "Enter your password",
                  lapel: "Password",
                  obscureText: visibilityPassword,
                ),
                SizedBox(height: 36.h),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(state.errorMessage ?? "An error occurred"),
                        ),
                      );
                    } else if (state is AuthSuccess) {
                      context.read<UserSessionBloc>().add(LogingUser());
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    } else {
                      return Container(
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          minWidth: double.infinity,
                          onPressed: () {
                            if (loginkey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    LoginEvent(
                                      loginModel: LoginModel(
                                        email: email.text,
                                        password: password.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                          color: const Color(0xff111111),
                          elevation: 0,
                          highlightElevation: 0,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: const Color(0xffE5E5E5), thickness: 1.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          color: const Color(0xff9E9E9E),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: const Color(0xffE5E5E5), thickness: 1.sp),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Loginwith(
                  text: "Continue with Google",
                  path: "images/logos_google-icon.png",
                  textcolor: const Color(0xff111111),
                  onPressed: () {
                    context.read<AuthBloc>().add(GoogleSignInEvent());
                  },
                ),
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: const Color(0xff757575),
                        fontSize: 15.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupView(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff111111),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}