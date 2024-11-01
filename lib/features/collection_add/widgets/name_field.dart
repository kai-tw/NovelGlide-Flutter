part of '../collection_add_dialog.dart';

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_Cubit>(context);
    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.collectionName,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return appLocalizations.collectionAddEmpty;
        } else {
          return null;
        }
      },
      onChanged: (value) {
        cubit.setName(value);
      },
    );
  }
}
