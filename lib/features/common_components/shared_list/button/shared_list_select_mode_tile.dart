part of '../shared_list.dart';

class SharedListSelectModeTile extends StatelessWidget {
  const SharedListSelectModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SizedBox(width: 24.0),
      title: Text(appLocalizations.generalSelect),
      trailing: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  static List<PopupMenuItem<void>>
      itemBuilder<T extends SharedListCubit<dynamic>>(BuildContext context) {
    final T cubit = BlocProvider.of<T>(context);
    return <PopupMenuItem<void>>[
      PopupMenuItem<void>(
        onTap: () => cubit.isSelecting = true,
        child: const SharedListSelectModeTile(),
      ),
    ];
  }
}
