import 'package:Discover/models/user_info_model.dart';
import 'package:Discover/services/profile_service.dart';
import 'package:Discover/view/account/widgets/account_menutile.dart';
import 'package:Discover/view/account/widgets/logout_button.dart';
import 'package:Discover/view/account/widgets/menu_section_card.dart';
import 'package:Discover/view/account/widgets/profile_header.dart';
import 'package:Discover/view/account/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AccountView extends StatefulWidget {
  AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final ProfileService profileService = ProfileService();

  @override
  void initState() {
    super.initState();
  }

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
              FutureBuilder<UserInfoModel?>(
                future: profileService.getCurrentUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ProfileHeader(user: snapshot.data!);
                  } else {
                    return ProfileHeader(
                      user: UserInfoModel(
                        id: '',
                        name: 'Guest',
                        email: 'guest@example.com',
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 30.h),

              SectionHeader(title: 'General'),
              MenuSectionCard(
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

              SectionHeader(title: 'Settings & Support'),
              MenuSectionCard(
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

              LogoutButton(),
              SizedBox(height: 75.h),
            ],
          ),
        ),
      ),
    );
  }
}

