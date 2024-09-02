import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/collection_add_bloc.dart';
import 'collection_add_form.dart';

class CollectionAddDialog extends StatelessWidget {
  const CollectionAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: BlocProvider(
          create: (context) => CollectionAddCubit(),
          child: const CollectionAddForm(),
        ),
      ),
    );
  }
}
