import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../settings/wrapper.dart';

class ReaderNavSettingsButton extends StatelessWidget {
  const ReaderNavSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return IconButton(
      icon: const Icon(Icons.settings_rounded),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: 1.0,
          showDragHandle: true,
          barrierColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: readerCubit,
              child: const ReaderSettingsBottomSheet(),
            );
          },
        );
      },
    );
  }
}