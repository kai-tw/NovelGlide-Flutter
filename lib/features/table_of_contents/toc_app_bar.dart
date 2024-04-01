import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/main.dart';

import '../common_components/common_back_button.dart';
import '../edit_book/edit_book_callee_edit_button.dart';
import 'bloc/toc_bloc.dart';

class TOCAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TOCAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      leading: CommonBackButton(popValue: cubit.isDirty),
      title: Text(appLocalizations.titleTOC),
      actions: [
        EditBookCalleeEditButton(
          bookObject: cubit.bookObject,
          onPopBack: (isSuccess) {
            if (isSuccess == true) {
              cubit.isDirty = true;
              cubit.refresh(isForce: true);
            }
          },
        ),
      ],
    );
  }
}
