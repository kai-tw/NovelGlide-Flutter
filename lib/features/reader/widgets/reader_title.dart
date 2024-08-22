import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderTitle extends StatelessWidget {
  const ReaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.bookName != current.bookName,
      builder: (BuildContext context, ReaderState state) {
        return Text(state.bookName);
      },
    );
  }
}
