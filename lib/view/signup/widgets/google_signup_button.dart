
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSignButton extends StatelessWidget {
  const GoogleSignButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<AuthBloc>().add(GoogleSignInEvent());
        },
        child: Container(
          width: 64.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xffE5E5E5),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              "images/logos_google-icon.png",
              width: 26.w,
              height: 26.h,
            ),
          ),
        ),
      ),
    );
  }
}


