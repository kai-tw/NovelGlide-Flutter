import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/reader_navigation_state_code.dart';
import '../../bloc/reader_cubit.dart';

class ReaderNavTtsCloseButton extends StatelessWidget {
  const ReaderNavTtsCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () =>
          cubit.setNavState(ReaderNavigationStateCode.defaultState),
    );
  }
}
