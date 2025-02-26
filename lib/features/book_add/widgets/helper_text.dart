part of '../book_add_dialog.dart';

class _HelperText extends StatelessWidget {
  const _HelperText();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookAddCubit>(context);
    final allowedExtensions = cubit.allowedExtensions.join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (previous, current) => previous.file != current.file,
        builder: (context, state) {
          final children = <Widget>[
            Text('${appLocalizations.fileTypeHelperText} $allowedExtensions'),
          ];

          if (!state.isEmpty && state.fileExists) {
            children.add(
              Text(
                appLocalizations.addBookDuplicated,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          }

          return Column(
            children: children,
          );
        },
      ),
    );
  }
}
