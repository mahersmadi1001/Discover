import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/core/Widgets/Loginwith.dart';
import 'package:Discover/core/Widgets/tfflogin.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';
import 'package:Discover/models/Loginmodel.dart';
import 'package:Discover/view/signup_view.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
bool visibility_password = true;

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: loginkey,
        child: Container(
          margin: EdgeInsets.all(24.sp),
          width: double.infinity,
          child: ListView(
            children: [
              Text(
                "Login to your account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
              ),
              Text(
                "It’s great to see you again",
                style: TextStyle(color: Color(0xff808080), fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                "Email",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              TFFLogin(
                controller: email,
                hint: "Enter your email address",
                lapel: "Email",
                obscureText: false,
              ),
              SizedBox(height: 26.h),
              Text(
                "Password",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              TFFLogin(
                controller: password,
                iconscure: IconButton(
                  onPressed: () {
                    setState(() {
                      visibility_password = !visibility_password;
                    });
                  },
                  icon: Icon(
                    visibility_password
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_outlined,
                  ),
                ),
                hint: "Enter your password",
                lapel: "Password",
                obscureText: visibility_password,
              ),

              SizedBox(height: 50.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger(
                      child: SnackBar(content: Text("Has error")),
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
                        context.read<AuthBloc>().add(
                          LoginEvent(
                            loginModel: LoginModel(
                              email: email.text,
                              password: password.text,
                            ),
                          ),
                        );
                      },
                      color: Colors.black,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 34.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Color(0xffE6E6E6), thickness: 2.sp),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or",
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
              Loginwith(
                text: "Login with Google",
                path: "images/logos_google-icon.png",
                textcolor: Colors.black,
                onPressed: () {
                  context.read<AuthBloc>().add(GoogleSignInEvent());
                },
              ),
              SizedBox(height: 16.h),
              Loginwith(
                text: "Login with Facebook",
                path: "images/logos_facebook.png",
                color: Color(0xff1877F2),
                textcolor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Facebook login coming soon")),
                  );
                },
              ),
              SizedBox(height: 100.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xff808080),
                            fontSize: 16.sp,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupView(),
                                ),
                              );
                            },
                            child: Text(
                              "Join",
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
}
