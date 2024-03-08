import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_back_button.dart';
import 'bloc/reader_cubit.dart';

class ReaderSliverAppBar extends StatelessWidget {
  const ReaderSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return SliverAppBar(
      leading: CommonBackButton(onPressed: () => cubit.dispose()),
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      pinned: true,
    );
  }
}
