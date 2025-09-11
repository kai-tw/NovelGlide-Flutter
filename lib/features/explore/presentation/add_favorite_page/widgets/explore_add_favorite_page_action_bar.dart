import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../shared_components/common_success_dialog.dart';
import '../cubits/explore_add_favorite_page_cubit.dart';
import '../cubits/explore_add_favorite_page_state.dart';

class ExploreAddFavoritePageActionBar extends StatelessWidget {
  const ExploreAddFavoritePageActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          label: Text(appLocalizations.generalClose),
        ),
        BlocBuilder<ExploreAddFavoritePageCubit, ExploreAddFavoritePageState>(
          buildWhen: (ExploreAddFavoritePageState previous,
                  ExploreAddFavoritePageState current) =>
              previous.isValid != current.isValid,
          builder: (BuildContext context, ExploreAddFavoritePageState state) {
            if (state.isValid) {
              return ElevatedButton.icon(
                onPressed: () => _submit(context),
                icon: const Icon(Icons.save_rounded),
                label: Text(appLocalizations.generalSave),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            } else {
              return TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.save_rounded),
                label: Text(appLocalizations.generalSave),
              );
            }
          },
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ExploreAddFavoritePageCubit cubit =
        BlocProvider.of<ExploreAddFavoritePageCubit>(context);

    final bool result = await cubit.submit();

    if (context.mounted) {
      if (result) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonSuccessDialog(
              content: appLocalizations.exploreAddFavoriteSuccess,
            );
          },
        );
      }
    }
  }
}
