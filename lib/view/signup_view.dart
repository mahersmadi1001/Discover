import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/core/Widgets/tfflogin.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';
import 'package:Discover/models/signup_model.dart';



class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  TextEditingController signupEmail = TextEditingController();
TextEditingController signupPassword = TextEditingController();
TextEditingController signupName = TextEditingController();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: signupKey,
        child: Container(
          margin: EdgeInsets.all(24.sp),
          width: double.infinity,
          child: ListView(
            children: [
              Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "Sign up to get started",
                style: TextStyle(color: Color(0xff808080), fontSize: 16.sp),
              ),
              SizedBox(height: 32.h),
              Text(
                "Full Name",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              TFFLogin(
                controller: signupName,
                hint: "Enter your full name",
                lapel: "Name",
                obscureText: false,
              ),
              SizedBox(height: 24.h),
              Text(
                "Email",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              TFFLogin(
                controller: signupEmail,
                hint: "Enter your email address",
                lapel: "Email",
                obscureText: false,
              ),
              SizedBox(height: 24.h),
              Text(
                "Password",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_outlined,
                    size: 24.sp,
                  ),
                ),
                hint: "Create a password",
                lapel: "Password",
                obscureText: signupVisibilityPassword,
              ),
              SizedBox(height: 16.h),
              Text(
                "By signing up, you agree to our Terms and Privacy Policy",
                style: TextStyle(color: Color(0xff808080), fontSize: 12.sp),
              ),
              SizedBox(height: 32.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? "Signup failed"),
                      ),
                    );
                  } else if (state is AuthSuccess) {
                    context.read<UserSessionBloc>().add(LogingUser());
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      minWidth: 341.w,
                      height: 54.h,
                      onPressed: () {
                        if (signupKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignupEvent(
                              signupModel: SignupModel(
                                username: signupName.text,
                                email: signupEmail.text,
                                password: signupPassword.text,
                              ),
                            ),
                          );
                        }
                      },
                      color: Colors.black,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Color(0xffE6E6E6), thickness: 2.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      "or sign up with",
                      style: TextStyle(
                        color: Color(0xffE6E6E6),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Color(0xffE6E6E6), thickness: 2.sp),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: "images/logos_google-icon.png",
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleSignInEvent());
                    },
                  ),
                  SizedBox(width: 24.w),
                  _buildSocialButton(
                    icon: "images/logos_facebook.png",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Facebook signup coming soon")),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xff808080),
                            fontSize: 16.sp,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE6E6E6), width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Image.asset(icon, width: 32.w, height: 32.h),
        ),
      ),
    );
  }
}
