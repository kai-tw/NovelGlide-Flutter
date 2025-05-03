import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/emoticon_collection.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../generated/i18n/app_localizations.dart';

part 'button/shared_list_delete_button.dart';
part 'button/shared_list_done_button.dart';
part 'button/shared_list_select_all_button.dart';
part 'button/shared_list_select_mode_button.dart';
part 'button/shared_list_select_mode_tile.dart';
part 'button/shared_list_sort_tile.dart';
part 'cubit/shared_list_cubit.dart';
part 'cubit/shared_list_state.dart';
part 'widgets/shared_list_empty.dart';
part 'widgets/shared_list_sliver_empty.dart';

class SharedListTile extends StatelessWidget {
  const SharedListTile({
    super.key,
    this.isSelecting = false,
    this.isSelected = false,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onChanged,
    this.onTap,
  });

  final bool isSelecting;
  final bool isSelected;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (isSelecting) {
      return CheckboxListTile(
        value: isSelected,
        onChanged: onChanged,
        secondary: leading,
        title: title,
        subtitle: subtitle,
      );
    } else {
      return ListTile(
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      );
    }
  }
}
