part of '../collection_add_dialog.dart';

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);
    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.collectionName,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return appLocalizations.collectionAddEmpty;
        } else {
          return null;
        }
      },
      onChanged: (String value) {
        cubit.setName(value);
      },
    );
  }
}
