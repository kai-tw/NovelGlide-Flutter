import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (BuildContext context, ReaderState state) {
          return Row(
            children: [
              Expanded(
                child: Text('Auto save the bookmark'),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          );
        },
      ),
    );
  }
}
