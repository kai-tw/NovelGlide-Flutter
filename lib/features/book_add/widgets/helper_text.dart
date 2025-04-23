part of '../book_add_dialog.dart';

class _HelperText extends StatelessWidget {
  const _HelperText();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String allowedExtensions = BookAddCubit.allowedExtensions.join(', ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (BookAddState previous, BookAddState current) =>
            previous.file != current.file,
        builder: (BuildContext context, BookAddState state) {
          final List<Widget> children = <Widget>[
            Text(
              '${appLocalizations.fileTypeHelperText} $allowedExtensions',
              textAlign: TextAlign.center,
            ),
          ];

          if (!state.isEmpty) {
            if (state.fileExists) {
              children.add(
                Text(
                  appLocalizations.addBookDuplicated,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }

            if (!state.isExtensionValid) {
              children.add(
                Text(
                  appLocalizations.fileTypeForbidden,
                  textAlign: TextAlign.center,
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
