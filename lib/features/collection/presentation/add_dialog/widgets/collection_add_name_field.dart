import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubit/collection_add_cubit.dart';

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
