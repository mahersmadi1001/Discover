import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF7F8F9),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
            color: const Color(0xFF1E232C),
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: const Color(0xFF1E232C),
                size: 26.sp,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 30.h),

              _buildSectionHeader('General'),
              _MenuSectionCard(
                children: [
                  AccountMenuTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    onTap: () {},
                  ),

                  AccountMenuTile(
                    icon: Icons.home_outlined,
                    title: 'Address Book',
                    onTap: () {},
                  ),
                  AccountMenuTile(
                    icon: Icons.credit_card_outlined,
                    title: 'Payment Methods',
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              _buildSectionHeader('Settings & Support'),
              _MenuSectionCard(
                children: [
                  AccountMenuTile(
                    icon: Icons.notifications_none_outlined,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  AccountMenuTile(
                    icon: Icons.help_outline,
                    title: 'FAQs',
                    onTap: () {},
                  ),
                  AccountMenuTile(
                    icon: Icons.headset_mic_outlined,
                    title: 'Help Center',
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              _buildLogoutButton(context),
              SizedBox(height: 75.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(7.sp),
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE8ECF4),
            border: Border.all(color: const Color(0xFFE8ECF4), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: Image.asset("images/Vector.png")),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ahmed Ali',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232C),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'ahmed@example.com',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8391A1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF8391A1),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: const Color(0xFFE53935),
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              'Logout',
              style: TextStyle(
                color: const Color(0xFFE53935),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E232C),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF8391A1),
                    fontSize: 15.sp,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE8ECF4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: const Color(0xFF1E232C),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        onPressed: () {
                          context.read<UserSessionBloc>().add(Signout());
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuSectionCard extends StatelessWidget {
  final List<Widget> children;

  const _MenuSectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class AccountMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const AccountMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r), 
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8F9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      icon,
                      color: const Color(0xFF1E232C),
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E232C),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: const Color(0xFF8391A1),
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: 60.w, right: 16.w),
            child: Divider(
              height: 1,
              thickness: 1,
              color: const Color(0xFFF0F1F5),
            ),
          ),
      ],
    );
  }
}
