import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'cubits/discover_browser_cubit.dart';
import 'discover_browser_scaffold.dart';

class DiscoverBrowser extends StatelessWidget {
  const DiscoverBrowser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscoverBrowserCubit>(
      create: (_) => sl<DiscoverBrowserCubit>(),
      child: const DiscoverBrowserScaffold(),
    );
  }
}
