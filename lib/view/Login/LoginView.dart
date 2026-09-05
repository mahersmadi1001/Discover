import 'package:Discover/view/Login/widgets/divider_login.dart';
import 'package:Discover/view/Login/widgets/login_button.dart';
import 'package:Discover/view/Login/widgets/nav_to_login.dart';
import 'package:Discover/view/signup/widgets/nav_to_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/core/Widgets/Loginwith.dart';
import 'package:Discover/core/Widgets/tfflogin.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';

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

                SizedBox(height: 8.h),
                CustomTextField(
                  controller: email,
                  hint: "Enter your email address",
                  label: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 20.h),

                SizedBox(height: 8.h),
                CustomTextField(
                  label: "Password",
                  controller: password,
                  suffixIcon: IconButton(
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

                  obscureText: visibilityPassword,
                ),
                SizedBox(height: 36.h),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            state.errorMessage ?? "An error occurred",
                          ),
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
                      return LoginButton(
                        loginkey: loginkey,
                        email: email,
                        password: password,
                      );
                    }
                  },
                ),
                SizedBox(height: 32.h),
                DividerLogin(),
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
                NavToSignup(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
