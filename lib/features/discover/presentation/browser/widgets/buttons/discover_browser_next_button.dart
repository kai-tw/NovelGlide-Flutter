import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/discover_browser_cubit.dart';
import '../../cubits/discover_browser_state.dart';

class DiscoverBrowserNextButton extends StatelessWidget {
  const DiscoverBrowserNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return BlocBuilder<DiscoverBrowserCubit, DiscoverBrowserState>(
      buildWhen:
          (DiscoverBrowserState previous, DiscoverBrowserState current) =>
              previous.code != current.code ||
              previous.restoreStack != current.restoreStack,
      builder: (BuildContext context, DiscoverBrowserState state) {
        return IconButton(
          onPressed: state.code.isLoading || state.restoreStack.isEmpty
              ? null
              : cubit.nextCatalog,
          icon: const Icon(Icons.arrow_forward_ios_rounded),
        );
      },
    );
  }
}
