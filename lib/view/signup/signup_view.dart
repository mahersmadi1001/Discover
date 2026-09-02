import 'package:Discover/view/signup/widgets/create_accont_button.dart';
import 'package:Discover/view/signup/widgets/divider_signup.dart';
import 'package:Discover/view/signup/widgets/google_signup_button.dart';
import 'package:Discover/view/signup/widgets/nav_to_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/core/Widgets/tfflogin.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  final TextEditingController signupEmail = TextEditingController();
  final TextEditingController signupPassword = TextEditingController();
  final TextEditingController signupName = TextEditingController();
  bool signupVisibilityPassword = true;

  @override
  void dispose() {
    signupEmail.dispose();
    signupPassword.dispose();
    signupName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAFAFA),
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: const Color(0xff111111),
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: signupKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: 12.h),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30.sp,
                    color: const Color(0xff111111),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Fill in the details below to get started",
                  style: TextStyle(
                    color: const Color(0xff757575),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 28.h),
                Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff222222),
                  ),
                ),
                SizedBox(height: 8.h),
                TFFLogin(
                  controller: signupName,
                  hint: "Enter your full name",
                  lapel: "Name",
                  obscureText: false,
                ),
                SizedBox(height: 20.h),
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
                  controller: signupEmail,
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
                  controller: signupPassword,
                  iconscure: IconButton(
                    onPressed: () {
                      setState(() {
                        signupVisibilityPassword = !signupVisibilityPassword;
                      });
                    },
                    icon: Icon(
                      signupVisibilityPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xff757575),
                      size: 20.sp,
                    ),
                  ),
                  hint: "Create a strong password",
                  lapel: "Password",
                  obscureText: signupVisibilityPassword,
                ),
                SizedBox(height: 16.h),
                Text(
                  "By signing up, you agree to our Terms and Privacy Policy",
                  style: TextStyle(
                    color: const Color(0xff9E9E9E),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 28.h),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(state.errorMessage ?? "Signup failed"),
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
                      return CreateAccountButton(
                        signupKey: signupKey,
                        signupName: signupName,
                        signupEmail: signupEmail,
                        signupPassword: signupPassword,
                      );
                    }
                  },
                ),
                SizedBox(height: 28.h),
                DividerSignup(),
                SizedBox(height: 20.h),
                GoogleSignButton(),
                SizedBox(height: 36.h),
                NavToLogin(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
