import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/models/Loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginkey,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> loginkey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
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
}
