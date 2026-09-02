import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
    required this.signupKey,
    required this.signupName,
    required this.signupEmail,
    required this.signupPassword,
  });

  final GlobalKey<FormState> signupKey;
  final TextEditingController signupName;
  final TextEditingController signupEmail;
  final TextEditingController signupPassword;

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
        color: const Color(0xff111111),
        elevation: 0,
        highlightElevation: 0,
        child: Text(
          "Create Account",
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
