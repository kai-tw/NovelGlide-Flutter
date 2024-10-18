import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/collection_add_bloc.dart';

class CollectionAddNameField extends StatelessWidget {
  const CollectionAddNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations?.collectionName ?? 'Collection Name',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      onChanged: (value) {
        BlocProvider.of<CollectionAddCubit>(context).name = value;
      },
    );
  }
}