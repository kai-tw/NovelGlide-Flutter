part of '../book_add_dialog.dart';

class _HelperText extends StatelessWidget {
  const _HelperText();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final allowedExtensions = BookAddCubit.allowedExtensions.join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (previous, current) => previous.file != current.file,
        builder: (context, state) {
          final children = <Widget>[
            Text('${appLocalizations.fileTypeHelperText} $allowedExtensions'),
          ];

          if (!state.isEmpty) {
            if (state.fileExists) {
              children.add(
                Text(
                  appLocalizations.addBookDuplicated,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }

            if (!state.isExtensionValid) {
              children.add(
                Text(
                  appLocalizations.fileTypeForbidden,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }
          }

          return Column(
            children: children,
          );
        },
      ),
    );
  }
}
