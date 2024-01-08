import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation_bloc.dart';

class MainPageAppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBarDefault({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titleList = [
      AppLocalizations.of(context)!.app_name,
      AppLocalizations.of(context)!.title_bookmarks,
      AppLocalizations.of(context)!.title_settings
    ];
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Align(
        alignment: Alignment.centerLeft,
        child: BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
          return Text(titleList[state.index]);
        }),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
