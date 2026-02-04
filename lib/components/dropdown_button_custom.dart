import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/gen/assets.gen.dart';
import '../core/theme/app_colors.dart';

class DropdownButtonCustom extends StatefulWidget {
  final String value;
  final List<DropdownMenuItem<String>>? lists;
  final ValueChanged<String?>? onChange;

  const DropdownButtonCustom({
    super.key,
    required this.value,
    this.lists,
    this.onChange,
  });

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
      child: Container(
        width: double.infinity,
        height: context.height * 0.060,
        padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColorLight, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButton<String>(
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 20,
            color: AppColors.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: AppColors.primaryColorDark,
          borderRadius: BorderRadius.circular(16),
          value: widget.value,
          isExpanded: true,
          underline: SizedBox(),
          icon: Center(
            child: Assets.icons.arrowDown.svg(
              width: context.paddingWidth16,
              height: context.paddingHeight16,
            ),
          ),
          items: widget.lists,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
