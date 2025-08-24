import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/discover_browser_cubit.dart';
import '../../cubits/discover_browser_state.dart';

class DiscoverBrowserHomeButton extends StatelessWidget {
  const DiscoverBrowserHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code,
      builder: (BuildContext context, DiscoverBrowserState state) {
        return IconButton(
          onPressed: state.code.isInitial || state.code.isLoading
              ? null
              : cubit.goHome,
          icon: const Icon(Icons.home_rounded),
        );
      },
    );
  }
}
