import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/discover_browser_cubit.dart';
import '../../cubits/discover_browser_state.dart';

class DiscoverBrowserPreviousButton extends StatelessWidget {
  const DiscoverBrowserPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code ||
              previous.historyStack != current.historyStack,
      builder: (BuildContext context, DiscoverBrowserState state) {
        return IconButton(
          onPressed: state.code.isLoading || state.historyStack.isEmpty
              ? null
              : cubit.previousCatalog,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        );
      },
    );
  }
}
