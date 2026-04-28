import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/dropdown_button_custom.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/provider/setting_cubit.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/custom_widget/divider_drawer_custom.dart';
import 'package:news/custom_widget/row_drawer_custom.dart';
import 'package:news/modules/cubit/home/home_cubit.dart';

class DrawerCustom extends StatefulWidget {
  final VoidCallback onTap;

  const DrawerCustom({super.key, required this.onTap});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          color: AppColors.primaryColorDark,
          height: double.infinity,
          width: context.width * 0.70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // عنوان التطبيق
              Container(
                width: context.width * 0.7,
                height: context.hg(166),
                color: AppColors.primaryColorLight,
                child: Center(
                  child: Text(
                    "News App",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: context.hg(24),
                      color: AppColors.primaryColorDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // زر العودة للصفحة الرئيسية
              RowDrawerCustom(
                icon: Assets.icons.homeIcon,
                text: 'Go To Home',
                onTap: widget.onTap,
              ),
              DividerDrawerCustom(),

              // Theme
              RowDrawerCustom(icon: Assets.icons.themeIcon, text: 'Theme'),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.paddingWidth16),
                  child: BlocBuilder<SettingsCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return DropdownButtonCustom<ThemeMode>(
                        value: themeMode,
                        lists: [
                          DropdownMenuItem(value: ThemeMode.dark, child: Text(
                              "Dark")),
                          DropdownMenuItem(value: ThemeMode.light, child: Text(
                              "Light")),
                          DropdownMenuItem(value: ThemeMode.system, child: Text(
                              "System")),
                        ],
                        onChange: (value) {
                          if (value != null) {
                            context.read<SettingsCubit>().changeTheme(value);
                          }
                        },
                      );
                    },
                  )
              ),

              SizedBox(height: context.hg(24)),
              DividerDrawerCustom(),

              // Country
              RowDrawerCustom(icon: Assets.icons.languageIcon, text: 'Country'),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingWidth16),
                child: DropdownButtonCustom<String>(
                  value: state.country,
                  lists: [
                    DropdownMenuItem(value: "Egypt", child: Text("Egypt")),
                    DropdownMenuItem(value: "KSA", child: Text("KSA")),
                    DropdownMenuItem(value: "US", child: Text("US")),
                    DropdownMenuItem(value: "UK", child: Text("UK")),
                    DropdownMenuItem(
                        value: "All Country", child: Text("All Country")),
                  ],
                  onChange: (value) {
                    if (value != null) {
                      context.read<HomeCubit>().changeCountry(value);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}