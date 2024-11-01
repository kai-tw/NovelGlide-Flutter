import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import '../../repository/collection_repository.dart';

part 'bloc/cubit.dart';
part 'widgets/cancel_button.dart';
part 'widgets/form.dart';
part 'widgets/name_field.dart';
part 'widgets/submit_button.dart';
part 'widgets/title_text.dart';

class CollectionAddDialog extends StatelessWidget {
  const CollectionAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: BlocProvider(
          create: (context) => _Cubit(),
          child: const _Form(),
        ),
      ),
    );
  }
}
