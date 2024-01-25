import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings/wrapper.dart';
import 'bloc/reader_cubit.dart';

class ReaderNavBar extends StatelessWidget {
  const ReaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return SizedBox(
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
          IconButton(onPressed: () {
            showModalBottomSheet(
              context: context,
              scrollControlDisabledMaxHeightRatio: 1.0,
              showDragHandle: true,
              barrierColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
              builder: (BuildContext context) {
                return BlocProvider.value(
                  value: cubit,
                  child: const ReaderSettingsBottomSheet(),
                );
              },
            );
          }, icon: const Icon(Icons.settings_rounded)),
        ],
      ),
    );
  }
}
