part of '../reset_service.dart';

class ResetServiceSettingsListTile extends StatelessWidget {
  const ResetServiceSettingsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SettingsListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<BookshelfCubit>.value(
                value: BlocProvider.of<BookshelfCubit>(context),
              ),
              BlocProvider<CollectionListCubit>.value(
                value: BlocProvider.of<CollectionListCubit>(context),
              ),
            ],
            child: const ResetPage(),
          ),
        ),
      ),
      iconData: Icons.refresh_rounded,
      title: appLocalizations.resetPageTitle,
    );
  }
}
