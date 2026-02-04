import 'package:flutter/material.dart';
import 'package:news/components/dropdown_button_custom.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/custom_widget/divider_drawer_custom.dart';

import '../custom_widget/row_drawer_custom.dart';

class DrawerCustom extends StatefulWidget {
  final VoidCallback onTap;

  const DrawerCustom({super.key, required this.onTap});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  String selectTheme = "Dark";
  String selectLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColorDark,
      height: double.infinity,
      width: context.width * 0.70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //newsApp
          Container(
            width: context.width * 0.7,
            height: 166,
            color: AppColors.primaryColorLight,
            child: Center(
              child: Text(
                "News App",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  color: AppColors.primaryColorDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          RowDrawerCustom(
            icon: Assets.icons.homeIcon,
            text: 'Go To Home',
            onTap: widget.onTap,
          ),
          DividerDrawerCustom(),
          RowDrawerCustom(icon: Assets.icons.themeIcon, text: 'Theme'),
          DropdownButtonCustom(
            value: selectTheme,
            lists: [
              DropdownMenuItem(value: "Dark", child: Text("Dark")),
              DropdownMenuItem(value: "Light", child: Text("Light")),
              DropdownMenuItem(value: "System", child: Text("System")),
            ],
            onChange: (value) {
              setState(() {
                selectTheme = value!;
              });
            },
          ),
          SizedBox(height: 24),
          DividerDrawerCustom(),
          RowDrawerCustom(icon: Assets.icons.languageIcon, text: 'Language'),
          DropdownButtonCustom(
            value: selectLanguage,
            lists: [
              DropdownMenuItem(value: "Arabic", child: Text("Arabic")),
              DropdownMenuItem(value: "English", child: Text("English")),
            ],
            onChange: (value) {
              setState(() {
                selectLanguage = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
