import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderPagination extends StatelessWidget {
  const ReaderPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.localCurrent != current.localCurrent || previous.localTotal != current.localTotal,
      builder: (context, state) {
        return Text("${state.localCurrent} / ${state.localTotal}");
      },
    );
  }
}