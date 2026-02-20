import 'package:flutter/material.dart';
import 'package:news/components/dropdown_button_custom.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/custom_widget/divider_drawer_custom.dart';
import 'package:news/modules/view%20model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../core/provider/app_setting_provider.dart';
import '../custom_widget/row_drawer_custom.dart';

class DrawerCustom extends StatefulWidget {
  final VoidCallback onTap;

  const DrawerCustom({super.key, required this.onTap});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  String selectTheme = "Dark";
  String selectCountry = "Egypt";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
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
              DropdownButtonCustom<ThemeMode>(
                value: context.watch<AppSettingProvider>().currentTheme,
                lists: [
                  DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text("Light"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text("System"),
                  ),
                ],
                onChange: (value) {
                  if (value != null) {
                    context.read<AppSettingProvider>().changeTheme(value);
                  }
                  viewModel.onTapChaneDrawerTheme(value!);
                },
              ),
              SizedBox(height: 24),
              DividerDrawerCustom(),
              RowDrawerCustom(icon: Assets.icons.languageIcon, text: 'Country'),
              DropdownButtonCustom<String>(
                value: viewModel.selectCountry,
                lists: [
                  DropdownMenuItem(value: "Egypt", child: Text("Egypt")),
                  DropdownMenuItem(value: "KSA", child: Text("KSA")),
                  DropdownMenuItem(value: "US", child: Text("US")),
                  DropdownMenuItem(value: "UK", child: Text("UK")),
                  DropdownMenuItem(
                    value: "All Country",
                    child: Text("All Country"),
                  ),
                ],
                onChange: (value) {
                  viewModel.onTapChaneDrawerCountry(value!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
