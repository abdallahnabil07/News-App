import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';

/// Custom styled dropdown widget used across the app.
///
/// Responsible for:
/// - Providing a consistent dropdown UI design
/// - Handling generic type selections
/// - Applying app theme styles (colors, typography, spacing)
class DropdownButtonCustom<T> extends StatefulWidget {
  /// Currently selected value
  final T value;

  /// List of dropdown items to display
  final List<DropdownMenuItem<T>>? lists;

  /// Callback triggered when user selects a new value
  final ValueChanged<T?>? onChange;

  const DropdownButtonCustom({
    super.key,
    required this.value,
    this.lists,
    this.onChange,
  });

  @override
  State<DropdownButtonCustom<T>> createState() =>
      _DropdownButtonCustomState<T>();
}

class _DropdownButtonCustomState<T> extends State<DropdownButtonCustom<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),

      /// ---------------- DROPDOWN CONTAINER ----------------
      child: Container(
        width: double.infinity,
        height: context.height * 0.060,
        padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),

        /// Border + styling for dropdown container
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColorLight, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),

        /// ---------------- DROPDOWN ----------------
        child: DropdownButton<T>(
          value: widget.value,
          items: widget.lists,
          onChanged: widget.onChange,
          isExpanded: true,
          underline: const SizedBox(),

          /// Dropdown text style
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: context.hg(20),
            color: AppColors.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),

          /// Dropdown menu background color
          dropdownColor: AppColors.primaryColorDark,

          borderRadius: BorderRadius.circular(16),

          /// Custom dropdown icon
          icon: Center(
            child: Assets.icons.arrowDown.svg(
              width: context.paddingWidth16,
              height: context.paddingHeight16,
            ),
          ),
        ),
      ),
    );
  }
}
