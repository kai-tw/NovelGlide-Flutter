import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/discover_browser_cubit.dart';

class DiscoverBrowserUrlBar extends StatelessWidget {
  const DiscoverBrowserUrlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit cubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: cubit.textEditingController,
          ),
        ),
        IconButton(
          onPressed: cubit.browseCatalog,
          icon: const Icon(Icons.search_rounded),
        ),
      ],
    );
  }
}
