import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/window_size.dart';
import '../../../../main.dart';
import 'cubit/collection_add_cubit.dart';
import 'widgets/collection_add_form.dart';

class CollectionAddDialog extends StatelessWidget {
  const CollectionAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WindowSize.compact.maxWidth),
        child: BlocProvider<CollectionAddCubit>(
          create: (_) => sl<CollectionAddCubit>(),
          child: const CollectionAddForm(),
        ),
      ),
    );
  }
}
