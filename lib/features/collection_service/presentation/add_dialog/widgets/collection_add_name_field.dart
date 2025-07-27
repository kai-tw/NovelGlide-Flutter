part of '../../../collection_service.dart';

class CollectionAddNameField extends StatelessWidget {
  const CollectionAddNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionAddCubit cubit =
        BlocProvider.of<CollectionAddCubit>(context);

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.collectionName,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      onChanged: (String value) => cubit.name = value,
    );
  }
}
