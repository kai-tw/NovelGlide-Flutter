import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubits/discover_add_favorite_page_cubit.dart';
import '../cubits/discover_add_favorite_page_state.dart';

class DiscoverAddFavoritePageActionBar extends StatelessWidget {
  const DiscoverAddFavoritePageActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final DiscoverAddFavoritePageCubit cubit =
        BlocProvider.of<DiscoverAddFavoritePageCubit>(context);

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
        BlocBuilder<DiscoverAddFavoritePageCubit, DiscoverAddFavoritePageState>(
          buildWhen: (DiscoverAddFavoritePageState previous,
                  DiscoverAddFavoritePageState current) =>
              previous.isValid != current.isValid,
          builder: (BuildContext context, DiscoverAddFavoritePageState state) {
            return TextButton.icon(
              onPressed: state.isValid
                  ? () {
                      cubit.submit();
                    }
                  : null,
              icon: const Icon(Icons.save_rounded),
              label: Text(appLocalizations.generalSave),
            );
          },
        ),
      ],
    );
  }
}
