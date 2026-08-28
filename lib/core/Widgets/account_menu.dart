// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountMenu extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback onTap;
  AccountMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: onTap,
            leading: Icon(icon, color: Colors.black87),
            title: Text(
              title,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ),
        Divider(height: 1.h, color: Colors.grey.shade200),
      ],
    );
  }
}
