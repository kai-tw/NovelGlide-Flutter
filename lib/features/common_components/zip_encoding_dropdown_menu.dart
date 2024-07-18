import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/zip_encoding.dart';

class ZipEncodingDropdownMenu extends StatelessWidget {
  final void Function(ZipEncoding? zipEncoding)? onSelected;

  const ZipEncodingDropdownMenu({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DropdownMenu(
        width: constraints.maxWidth,
        inputDecorationTheme: Theme.of(context).inputDecorationTheme,
        initialSelection: ZipEncoding.utf8,
        label: Text(AppLocalizations.of(context)!.zipEncodingLabel),
        helperText: AppLocalizations.of(context)!.zipEncodingLabelHelperText,
        enableSearch: false,
        trailingIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          semanticLabel: AppLocalizations.of(context)!.zipEncodingTrailingIconExpand,
        ),
        selectedTrailingIcon: Icon(
          Icons.keyboard_arrow_up_rounded,
          semanticLabel: AppLocalizations.of(context)!.zipEncodingTrailingIconCollapse,
        ),
        dropdownMenuEntries: ZipEncoding.values
            .map(
              (ZipEncoding zipEncoding) => DropdownMenuEntry(
                value: zipEncoding,
                label: zipEncoding.value,
              ),
            )
            .toList(),
        onSelected: onSelected,
      );
    });
  }
}
