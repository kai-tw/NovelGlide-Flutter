import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      leading: BlocBuilder<TOCCubit, TOCState>(builder: (_, state) => CommonBackButton(popValue: state.isDirty)),
      title: Text(appLocalizations.titleTOC),
      actions: [
        EditBookCalleeEditButton(
          bookObject: cubit.bookObject,
          onPopBack: (isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isSuccess ? appLocalizations.editBookSuccessfully : appLocalizations.editBookFailed),
            ));

            if (isSuccess == true) {
              cubit.setDirty();
              cubit.refresh(isForce: true);
            }
          },
        ),
      ],
    );
  }
}
