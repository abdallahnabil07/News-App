import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/settings/setting_cubit.dart';
import 'package:news/core/routes/app_routes_name.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/presentation/cubit/home/home_cubit.dart';
import 'package:news/features/news/presentation/widgets/home/divider_drawer_custom.dart';
import 'package:news/features/news/presentation/widgets/home/row_drawer_custom.dart';

import 'dropdown_button_custom.dart';

/// Custom navigation drawer for the News app.
///
/// Responsible for:
/// - Navigating between main sections (Home, Bookmarks)
/// - Changing app theme (light/dark/system)
/// - Changing selected country for news filtering
/// - Providing quick app settings access
class DrawerCustom extends StatefulWidget {
  /// Callback used to return to home screen
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

          /// ---------------- DRAWER CONTENT ----------------
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// ---------------- APP TITLE ----------------
              Container(
                width: context.width * 0.7,
                height: context.hg(166),
                color: AppColors.primaryColorLight,
                child: Center(
                  child: Text(
                    AppStrings.appName,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: context.hg(24),
                      color: AppColors.primaryColorDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              /// ---------------- HOME NAVIGATION ----------------
              RowDrawerCustom(
                icon: Assets.icons.homeIcon,
                text: AppStrings.goToHome,
                onTap: widget.onTap,
              ),
              const DividerDrawerCustom(),

              /// ---------------- BOOKMARKS ----------------
              RowDrawerCustom(
                pngIcon: Assets.images.bookmark,
                text: AppStrings.bookmarks,
                iconSize: 24,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutesName.bookmark).then((
                    _,
                  ) {
                    // Refresh UI after returning from bookmarks screen
                    setState(() {});
                  });
                },
              ),
              const DividerDrawerCustom(),

              /// ---------------- THEME SECTION ----------------
              RowDrawerCustom(
                icon: Assets.icons.themeIcon,
                text: AppStrings.theme,
              ),

              /// Theme dropdown selector
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingWidth16,
                ),
                child: BlocBuilder<SettingsCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return DropdownButtonCustom<ThemeMode>(
                      value: themeMode,
                      lists: const [
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text(AppStrings.light),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text(AppStrings.dark),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text(AppStrings.systemDefault),
                        ),
                      ],
                      onChange: (value) {
                        if (value != null) {
                          context.read<SettingsCubit>().changeTheme(value);
                        }
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: context.hg(24)),
              const DividerDrawerCustom(),

              /// ---------------- COUNTRY FILTER ----------------
              RowDrawerCustom(
                icon: Assets.icons.languageIcon,
                text: AppStrings.country,
              ),

              /// Country selector dropdown
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingWidth16,
                ),
                child: DropdownButtonCustom<String?>(
                  value: state.country,
                  lists: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppStrings.allCountries),
                    ),
                    DropdownMenuItem(value: "us", child: Text(AppStrings.usa)),
                    DropdownMenuItem(value: "gb", child: Text(AppStrings.uk)),
                    DropdownMenuItem(
                      value: "de",
                      child: Text(AppStrings.germany),
                    ),
                    DropdownMenuItem(
                      value: "fr",
                      child: Text(AppStrings.france),
                    ),
                    DropdownMenuItem(
                      value: "it",
                      child: Text(AppStrings.italy),
                    ),
                    DropdownMenuItem(
                      value: "ru",
                      child: Text(AppStrings.russia),
                    ),
                  ],
                  onChange: (value) {
                    context.read<HomeCubit>().changeCountry(value);
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
