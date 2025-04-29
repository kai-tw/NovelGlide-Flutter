import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/window_class.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../data/collection_repository.dart';

part 'cubit/cubit.dart';
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
        child: BlocProvider<_Cubit>(
          create: (_) => _Cubit(),
          child: const _Form(),
        ),
      ),
    );
  }
}
