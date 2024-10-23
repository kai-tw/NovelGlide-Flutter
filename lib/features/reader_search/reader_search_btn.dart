import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/loading_state_code.dart';
import '../../toolbox/route_helper.dart';
import '../reader/bloc/reader_cubit.dart';
import '../reader/bloc/reader_state.dart';
import 'reader_search.dart';

class ReaderSearchBtn extends StatelessWidget {
  const ReaderSearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isDisabled = state.code != LoadingStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: AppLocalizations.of(context)!.readerSearch,
          ),
          onPressed: isDisabled
              ? null
              : () {
                  Navigator.of(context).push(
                    RouteHelper.pushRoute(
                      BlocProvider.value(
                        value: cubit.searchCubit,
                        child: const ReaderSearch(),
                      ),
                    ),
                  );
                },
        );
      },
    );
  }
}
